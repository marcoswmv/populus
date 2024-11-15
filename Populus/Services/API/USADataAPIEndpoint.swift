//
//  USADataAPIEndpoint.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

typealias Fields = [String: Any]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol EndpointType {
    var httpMethod: RequestMethod { get }
    var queryItems: [URLQueryItem] { get }
    var fields: Fields? { get }
}

enum USADataAPIEndpoint {
    case data(AdministrativeAreaLevel = .nation, Year? = nil)
}

extension USADataAPIEndpoint: EndpointType {

    private var baseURL: String {
        AppConfigs.APIBaseURL
    }

    func generateURLRequest() -> URLRequest? {
        guard var urlComponents: URLComponents = .init(string: baseURL) else { return nil }
        urlComponents.queryItems = self.queryItems

        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue

        self.fields?.forEach { (fieldKey: String, value: Any) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: fieldKey)
            }
        }
        return urlRequest
    }

    var httpMethod: RequestMethod {
        switch self {
        case .data:
            return .get
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .data(let area, let year):
            var items: [URLQueryItem] = [
                URLQueryItem(name: AppConfigs.Keys.drilldowns, value: AppConfigs.Values.set(administrativeAreaLevel: area)),
                URLQueryItem(name: AppConfigs.Keys.measures, value: AppConfigs.Values.set(measure: .population)),
            ]
            if let year {
                items.append(URLQueryItem(name: AppConfigs.Keys.year, value: AppConfigs.Values.set(year: year)))
            }
            return items
        }
    }

    var fields: Fields? {
        switch self {
        case .data:
            return ["Content-type": "application/json",
                    "Accept": "application/json"]
        }
    }
}
