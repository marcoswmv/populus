//
//  PopulationListViewModel.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import Foundation
import Combine

// TO-DO: Implement Protocol as an interface to improve Testability and code reusage

final class PopulationListViewModel: ObservableObject {

    @Published var populationData: [PopulationData] = PopulationDataResponse.mocked
    @Published var areaLevel: AdministrativeAreaLevel = .state
    @Published var timeFilter: Year = .latest
    @Published var errorDescription: String = .init()

    private var networkService: NetworkServiceProtocol
    private var cancellables: Set<AnyCancellable> = .init()
    private var backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    private func requestData(areaLevel: AdministrativeAreaLevel, year: Year = .latest) {
        do {
            try networkService.requestPopulationData(at: areaLevel, on: year)
                .subscribe(on: backgroundQueue)
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    guard let self else { return }
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.errorDescription = error.localizedDescription
                    }
                } receiveValue: { [weak self] responseData in
                    guard let self else { return }
                    self.populationData = responseData.data
                }
                .store(in: &cancellables)
        } catch {
            print("QWER" + error.localizedDescription)
            self.errorDescription = error.localizedDescription
        }
    }

    func fetchData() {
        requestData(areaLevel: areaLevel, year: timeFilter)
    }
}
