//
//  NetworkError.swift
//  Populus
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation

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

    static func mapError(for status: Int) -> Self {
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
}
