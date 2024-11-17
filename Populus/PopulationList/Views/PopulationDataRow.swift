//
//  PopulationDataRow.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

struct PopulationDataRow: View {

    var viewModel: PopulationDataViewModel

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(viewModel.locationName)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack {
                    Text(AppStrings.populationLabel)
                    Text(String(viewModel.population.formattedToDecimalString))
                        .fontWeight(.bold)
                }
                .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewModel.year)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PopulationDataRow(
        viewModel: .init(
            locationName: "Alabama",
            year: "2022",
            population: 5028092
        )
    )
}
