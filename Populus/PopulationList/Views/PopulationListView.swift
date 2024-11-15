//
//  PopulationListView.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

struct PopulationListView: View {

    @EnvironmentObject private var viewModel: PopulationListViewModel
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
            .onAppear {
                viewModel.fetchData()
            }
            .onChange(of: viewModel.areaLevel) { (_, value) in
                viewModel.fetchData()
            }
            .onChange(of: viewModel.timeFilter) { (_, value) in
                viewModel.fetchData()
            }
            .onChange(of: viewModel.errorDescription) { (oldValue, newValue) in
                if !newValue.isEmpty {
                    showingAlert.toggle()
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

    @StateObject private var viewModel: PopulationListViewModel = .init(networkService: NetworkService())

    var body: some View {
        PopulationListView()
            .environmentObject(viewModel)
    }
}

#Preview {
    PreviewPopulationListView()
}
