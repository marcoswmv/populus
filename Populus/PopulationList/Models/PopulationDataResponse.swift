//
//  PopulationDataResponse.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

struct PopulationDataResponse: Decodable {
    let data: [PopulationData]
}

extension PopulationDataResponse {
    static var dummy: PopulationDataResponse = .init(
        data:
        [
            .init(state: "Alabama", year: "2022", population: 5028092),
            .init(state: "Alaska", year: "2022", population: 734821),
            .init(state: "Arizona", year: "2022", population: 7172282),
            .init(state: "Arkansas", year: "2022", population: 3018669),
            .init(state: "California", year: "2022", population: 39356104),
            .init(state: "Colorado", year: "2022", population: 5770790),
            .init(state: "Arizona", year: "2022", population: 7172282),
            .init(state: "Arkansas", year: "2022", population: 3018669),
            .init(state: "California", year: "2022", population: 39356104),
            .init(state: "Colorado", year: "2022", population: 5770790),
            .init(state: "Arizona", year: "2022", population: 7172282),
            .init(state: "Arkansas", year: "2022", population: 3018669),
            .init(state: "California", year: "2022", population: 39356104),
            .init(state: "Colorado", year: "2022", population: 5770790),
            .init(state: "Arizona", year: "2022", population: 7172282),
            .init(state: "Arkansas", year: "2022", population: 3018669),
            .init(state: "California", year: "2022", population: 39356104),
            .init(state: "Colorado", year: "2022", population: 5770790),
        ]
    )
}
