//
//  PopulationListViewModel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation
import Combine

protocol PopulationListViewModelProtocol: AnyObject, ObservableObject {
    var populationData: [PopulationDataViewModel] { get set }
    var location: LocationType { get set }
    var year: Year { get set }
    var errorDescription: String { get set }

    func fetchData()
}

final class PopulationListViewModel: PopulationListViewModelProtocol {

    private var service: PopulationServiceProtocol
    private var backgroundQueue: DispatchQueue
    private var cancellables: Set<AnyCancellable>

    @Published var populationData: [PopulationDataViewModel]
    @Published var location: LocationType
    @Published var year: Year
    @Published var errorDescription: String


    init(
        service: PopulationServiceProtocol,
        queue: DispatchQueue = .global(qos: .background)
    ) {
        self.service = service
        self.backgroundQueue = queue
        self.cancellables = .init()
        self.populationData = []
        self.location = .state
        self.year = .latest
        self.errorDescription = .init()

        $location
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.requestData(for: value, year: year)
            })
            .store(in: &cancellables)

        $year
            .dropFirst()
            .sink(receiveValue: { [weak self] value in
                guard let self else { return }
                self.requestData(for: location, year: value)
            })
            .store(in: &cancellables)
    }

    private func requestData(
        for location: LocationType,
        year: Year = .all
    ) {
        service.requestPopulationData(
            at: location,
            on: year
        ) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.populationData = Parser.generateViewModel(from: response.data)
                case .failure(let error):
                    self.errorDescription = error.description
                }
            }
        }
    }

    func fetchData() {
        requestData(for: location, year: year)
    }
}
