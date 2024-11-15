//
//  APIEndpoint.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

typealias Fields = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol EndpointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var fields: Fields? { get }
}

enum APIEndpoint {
    case data(AdministrativeAreaLevel = .nation, Year? = nil)
}

extension APIEndpoint: EndpointType {

    func generateURLRequest(baseURL: String) -> URLRequest {
        guard var urlComponents: URLComponents = .init(string: baseURL) else { return .init(url: .temporaryDirectory) }
        urlComponents.path = self.path
        urlComponents.queryItems = self.queryItems

        guard let url = urlComponents.url else { return .init(url: .temporaryDirectory) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue

        self.fields?.forEach { (fieldKey: String, value: Any) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: fieldKey)
            }
        }
        return urlRequest
    }

    var path: String {
        switch self {
        case .data:
            "/api/data"
        }
    }

    var httpMethod: HTTPMethod {
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
