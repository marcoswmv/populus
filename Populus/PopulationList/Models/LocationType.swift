//
//  AdministrativeAreaLevel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

enum LocationType: String, CaseIterable, Identifiable {
    case state = "State"
    case nation = "Nation"

    var id: Self { self }
}
