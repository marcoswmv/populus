//
//  APIEnvironment.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

enum APIEnvironment {
    case development

    var baseUrl: String {
        switch self {
        case .development:
            guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: AppConfigs.Keys.baseUrl) as? String else {
                fatalError("ApiBaseURL must not be empty in plist")
            }
            return apiBaseURL
        }
    }
}
