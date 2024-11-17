//
//  NetworkManager.swift
//  Populus
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    var baseURL: String { get set }
    var session: URLSession { get set }
    var decoder: JSONDecoder { get set }

    func request<T: Decodable>(endpoint: APIEndpoint, completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
    func decode<T: Decodable>(_ data: Data?, _ completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

extension NetworkManager: NetworkManagerProtocol {
    func request<T>(
        endpoint: APIEndpoint,
        completionHandler: @escaping ((Result<T, NetworkError>) -> Void)
    ) where T : Decodable {
        let urlRequest = endpoint.generateURLRequest(baseURL: self.baseURL)
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self,
                  let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                completionHandler(.failure(NetworkError.mapError(for: (response as? HTTPURLResponse)?.statusCode ?? -1)))
                return
            }
            self.decode(data, completionHandler)
        }
        task.resume()
    }
}

final class NetworkManager {

    var baseURL: String
    var session: URLSession
    var decoder: JSONDecoder

    init(
        environment: APIEnvironment = .development,
        session: URLSession = .shared,
        decoder: JSONDecoder = .init()
    ) {
        self.baseURL = environment.baseUrl
        self.session = session
        self.decoder = decoder
    }

    func decode<T: Decodable>(
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
