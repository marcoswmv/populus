//
//  PopulationListView.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

struct PopulationListView: View {

    @EnvironmentObject private var viewModel: PopulationListViewModel

    var body: some View {
        VStack {
            List(viewModel.populationData) { data in
                PopulationDataRow(model: data)
            }
        }
    }
}

struct PreviewPopulationListView: View {

    @StateObject private var viewModel: PopulationListViewModel = .init()

    var body: some View {
        PopulationListView()
            .environmentObject(viewModel)
    }
}

#Preview {
    PreviewPopulationListView()
}
