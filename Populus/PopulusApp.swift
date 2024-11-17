//
//  PopulusApp.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

@main
struct PopulusApp: App {
    
    @StateObject private var viewModel: PopulationListViewModel = .init(service: PopulationService(service: NetworkManager()))

    var body: some Scene {
        WindowGroup {
                PopulationListView<PopulationListViewModel>()
                    .environmentObject(viewModel)
        }
    }
}
