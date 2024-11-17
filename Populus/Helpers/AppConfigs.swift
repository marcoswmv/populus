//
//  AppConfigs.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

enum AppConfigs {
    enum Keys {
        case drilldowns(LocationType)
        case measures(Measure)
        
        static let baseUrl = "BASE_URL"
        static let drilldowns = "drilldowns"
        static let measures = "measures"
        static let year = "year"
        static let limit = "limit"
    }

    enum Values {
        static func set(location: LocationType) -> String {
            location.rawValue
        }

        static func set(measure: Measure) -> String {
            measure.rawValue
        }

        static func set(year: Year) -> String {
            year.rawValue
        }
    }
}
