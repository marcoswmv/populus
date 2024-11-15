//
//  NetworkService.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import UIKit
import Combine

private enum LocalError: Error {
    case unwrapping
}

protocol NetworkServiceProtocol {
    func requestPopulationData(
        at administrativeAreaLevel: AdministrativeAreaLevel,
        on year: Year?
    ) throws -> AnyPublisher<PopulationDataResponse, Error>
}

extension NetworkService: NetworkServiceProtocol {
    func requestPopulationData(
        at administrativeAreaLevel: AdministrativeAreaLevel,
        on year: Year? = nil
    ) throws -> AnyPublisher<PopulationDataResponse, Error> {
        try request(endpoint: .data(administrativeAreaLevel, year))
    }
}

final class NetworkService {
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
}

extension NetworkService {
    private func request<T: Decodable>(endpoint: USADataAPIEndpoint) throws -> AnyPublisher<T, Error> {
        guard let urlRequest = endpoint.generateURLRequest() else { throw LocalError.unwrapping }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw URLError(URLError.Code(rawValue: (element.response as? HTTPURLResponse)?.statusCode ?? 400))
                }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
