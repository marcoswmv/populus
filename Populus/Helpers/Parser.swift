//
//  Parser.swift
//  Populus
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation

struct Parser {
    static func generateViewModel(from data: [PopulationData]) -> [PopulationDataViewModel] {
        return data.map { data in
            PopulationDataViewModel(
                locationName: data.nation ?? data.state ?? .init(),
                year: data.year,
                population: data.population
            )
        }
    }
}
