//
//  String+Extension.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation

extension String {
    var formattedToDecimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: Int(self) ?? .zero)
        return formatter.string(from: number) ?? .init()
    }
}
