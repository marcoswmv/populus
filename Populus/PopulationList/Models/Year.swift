//
//  Year.swift
//  Populus
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation

enum Year: String, CaseIterable, Identifiable {
    case latest = "latest"
    case oldest = "oldest"
    case all = "all"

    var id: Self { self }
}
