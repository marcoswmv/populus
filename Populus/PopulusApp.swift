//
//  PopulusApp.swift
//  Populus
//
//  Created by Marcos Vicente on 14/11/2024.
//

import SwiftUI

@main
struct PopulusApp: App {
    
    @StateObject private var viewModel: PopulationListViewModel = .init(networkManager: NetworkManager())

    var body: some Scene {
        WindowGroup {
            PopulationListView(viewModel: viewModel)
        }
    }
}
