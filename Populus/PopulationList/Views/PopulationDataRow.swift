//
//  PopulationDataRow.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

struct PopulationDataRow: View {

    var model: PopulationData

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(model.administrativeAreaName)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack {
                    Text(AppStrings.populationLabel)
                    Text(String(model.population.formattedToDecimalString))
                        .fontWeight(.bold)
                }
                .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(model.year)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PopulationDataRow(
        model: .init(
            state: "Alabama",
            year: "2022",
            population: 5028092
        )
    )
}
