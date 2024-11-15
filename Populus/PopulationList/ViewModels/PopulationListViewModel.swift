//
//  PopulationListViewModel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

// TO-DO: Implement Protocol as an interface to improve Testability and code reusage

final class PopulationListViewModel: ObservableObject {

    @Published var populationData: [PopulationData] = [
        .init(state: "Alabama", year: "2022", population: "5028092"),
        .init(state: "Alaska", year: "2022", population: "734821"),
        .init(state: "Arizona", year: "2022", population: "7172282"),
        .init(state: "Arkansas", year: "2022", population: "3018669"),
        .init(state: "California", year: "2022", population: "39356104"),
        .init(state: "Colorado", year: "2022", population: "5770790")
    ]
}
