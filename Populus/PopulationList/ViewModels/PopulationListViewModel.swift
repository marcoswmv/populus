//
//  PopulationListViewModel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation
import Combine

protocol PopulationListViewModelProtocol: AnyObject, ObservableObject {
    var populationData: [PopulationData] { get set }
    var areaLevel: AdministrativeAreaLevel { get set }
    var timeFilter: Year { get set }
    var errorDescription: String { get set }
}

final class PopulationListViewModel: PopulationListViewModelProtocol {

    @Published var populationData: [PopulationData] = PopulationDataResponse.mocked
    @Published var areaLevel: AdministrativeAreaLevel = .state
    @Published var timeFilter: Year = .latest
    @Published var errorDescription: String = .init()

    private var networkManager: NetworkManagerProtocol
    private var cancellables: Set<AnyCancellable> = .init()
    private var backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager

        $areaLevel
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.requestData(areaLevel: value, year: timeFilter)
            })
            .store(in: &cancellables)

        $timeFilter
            .dropFirst()
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.requestData(areaLevel: areaLevel, year: value)
            })
            .store(in: &cancellables)
    }

    private func requestData(areaLevel: AdministrativeAreaLevel, year: Year = .all) {
        networkManager.requestPopulationData(at: areaLevel, on: year) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.populationData = response.data
                case .failure(let error):
                    self.errorDescription = error.description
                }
            }
        }
    }
}
