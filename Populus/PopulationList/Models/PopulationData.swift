//
//  PopulationData.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import Foundation

struct PopulationData: Identifiable, Hashable, Decodable {
    var id: String {
        UUID().uuidString
    }
    var state: String?
    var nation: String?
    var year: String
    var population: Int

    var administrativeAreaName: String {
        nation ?? state ?? .init()
    }

    enum CodingKeys: String, CodingKey {
        case state = "State"
        case nation = "Nation"
        case year = "Year"
        case population = "Population"
    }
}
