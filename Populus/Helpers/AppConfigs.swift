//
//  AppConfigs.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

enum AppConfigs {
    enum Keys {
        case drilldowns(AdministrativeAreaLevel)
        case measures(Measure)

        static let baseUrl = "BASE_URL"
        static let drilldowns = "drilldowns"
        static let measures = "measures"
        static let year = "year"
        static let limit = "limit"
    }

    enum Values {
        static func set(administrativeAreaLevel: AdministrativeAreaLevel) -> String {
            administrativeAreaLevel.rawValue
        }

        static func set(measure: Measure) -> String {
            measure.rawValue
        }

        static func set(year: Year) -> String {
            year.rawValue
        }
    }

    static var APIBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: Keys.baseUrl) as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}

enum AdministrativeAreaLevel: String, CaseIterable, Identifiable {
    case state = "State"
    case nation = "Nation"

    var id: Self { self }
}

enum Measure: String {
    case population = "Population"
}

enum Year: String, CaseIterable, Identifiable {
    case latest = "latest"
    case oldest = "oldest"
    case all = "all"
    
    var id: Self { self }
}
