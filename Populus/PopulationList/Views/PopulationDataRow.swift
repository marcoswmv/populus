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
                    Text(model.population.formattedToDecimal)
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
            //            nation: "United States",
            year: "2022",
            population: "5.028.092"
        )
    )
}
