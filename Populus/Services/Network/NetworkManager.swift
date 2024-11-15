//
//  NetworkManager.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import UIKit
import Combine

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case clientError
    case internalServerError
    case notImplemented
    case badGateway
    case serverError
    case requestFailed(String)
    case decodingFailed

    var description: String {
        self.localizedDescription.debugDescription
    }
}

protocol NetworkService {
    func request<T: Decodable>(endpoint: APIEndpoint, completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
}

protocol NetworkManagerProtocol {
    func requestPopulationData(at administrativeAreaLevel: AdministrativeAreaLevel, on year: Year?, completionHandler: @escaping ((Result<PopulationDataResponse, NetworkError>) -> Void))
}

extension NetworkManager: NetworkManagerProtocol {
    func requestPopulationData(
        at administrativeAreaLevel: AdministrativeAreaLevel,
        on year: Year?,
        completionHandler: @escaping ((Result<PopulationDataResponse, NetworkError>) -> Void)
    ) {
        request(endpoint: .data(administrativeAreaLevel, year), completionHandler: completionHandler)
    }
}

extension NetworkManager: NetworkService {
    func request<T>(
        endpoint: APIEndpoint,
        completionHandler: @escaping ((Result<T, NetworkError>) -> Void)
    ) where T : Decodable {
        let urlRequest = endpoint.generateURLRequest(baseURL: self.baseURL)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self else { return }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                completionHandler(.failure(handleNetworkError(with: (response as? HTTPURLResponse)?.statusCode ?? -1)))
                return
            }
            decode(data, completionHandler)
        }
        task.resume()
    }
}

final class NetworkManager {

    private var baseURL: String
    private var decoder: JSONDecoder

    init(
        environment: APIEnvironment = NetworkManager.defaultEnvironment(),
        decoder: JSONDecoder = .init()
    ) {
        self.baseURL = environment.baseUrl
        self.decoder = decoder
    }

    static func defaultEnvironment() -> APIEnvironment {
        return .production
    }

    private func handleNetworkError(with status: Int) -> NetworkError {
        return switch status {
        case 400:
            NetworkError.badRequest
        case 401:
            NetworkError.unauthorized
        case 403:
            NetworkError.forbidden
        case 404:
            NetworkError.notFound
        case 405..<500:
            NetworkError.clientError
        case 500:
            NetworkError.internalServerError
        case 501:
            NetworkError.notImplemented
        case 502:
            NetworkError.badGateway
        case 500..<600:
            NetworkError.serverError
        default:
            NetworkError.requestFailed("An error occurred.")
        }
    }

    private func decode<T: Decodable>(
        _ data: Data?,
        _ completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let data else { return }
        do {
            let responseData = try decoder.decode(T.self, from: data)
            completionHandler(.success(responseData))
        } catch {
            completionHandler(.failure(NetworkError.decodingFailed))
        }
    }
}
