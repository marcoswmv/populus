//
//  PopulationListView.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

struct PopulationListView<ViewModel: PopulationListViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel
    @State private var showingAlert: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.populationData) { data in
                    PopulationDataRow(model: data)
                }
            }
            .alert(
                viewModel.errorDescription,
                isPresented: $showingAlert,
                actions: {
                    Button(
                        AppStrings.errorAlertButtonTitle,
                        role: .cancel
                    ) {}
                }
            )
            .onChange(of: viewModel.errorDescription) { (_, value) in
                if !value.isEmpty {
                    showingAlert = true
                }
            }

            .navigationTitle(AppStrings.populationTitle)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Picker("", selection: $viewModel.areaLevel) {
                        ForEach(AdministrativeAreaLevel.allCases) { item in
                            Text(item.rawValue)
                                .tag(item)
                        }
                    }

                    Picker("", selection: $viewModel.timeFilter) {
                        ForEach(Year.allCases) { item in
                            Text(item.rawValue.capitalized)
                                .tag(item)
                        }
                    }
                }
            }
        }
    }
}

struct PreviewPopulationListView: View {

    @StateObject private var viewModel: PopulationListViewModel = .init(networkManager: NetworkManager())

    var body: some View {
        PopulationListView(viewModel: viewModel)
    }
}

#Preview {
    PreviewPopulationListView()
}
