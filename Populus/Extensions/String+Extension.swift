//
//  String+Extension.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
