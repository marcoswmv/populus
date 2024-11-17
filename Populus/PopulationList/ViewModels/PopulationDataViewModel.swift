//
//  PopulationDataViewModel.swift
//  Populus
//
//  Created by Marcos Vicente on 16/11/2024.
//

import SwiftUI

struct PopulationDataViewModel: Identifiable, Hashable {
    var id: String {
        UUID().uuidString
    }
    var locationName: String
    var year: String
    var population: Int
}
