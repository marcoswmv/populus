//
//  PopulationData.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import Foundation

struct PopulationData: Decodable {
    var state: String?
    var nation: String?
    var year: String
    var population: Int

    enum CodingKeys: String, CodingKey {
        case state = "State"
        case nation = "Nation"
        case year = "Year"
        case population = "Population"
    }
}

extension PopulationData {
    static var dummy: PopulationData = .init(state: "Alabama", year: "2022", population: 5028092)
}
