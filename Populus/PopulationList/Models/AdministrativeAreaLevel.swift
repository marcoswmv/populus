//
//  AdministrativeAreaLevel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

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
