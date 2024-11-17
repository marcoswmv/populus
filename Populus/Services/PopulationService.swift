//
//  PopulationService.swift
//  Populus
//
//  Created by Marcos Vicente on 15/11/2024.
//

import UIKit

typealias PopulationDataResultBlock = ((Result<PopulationDataResponse, NetworkError>) -> Void)

protocol PopulationServiceProtocol {
    func requestPopulationData(at location: LocationType, on year: Year?, completionHandler: @escaping PopulationDataResultBlock)
}

extension PopulationService: PopulationServiceProtocol {
    func requestPopulationData(
        at location: LocationType,
        on year: Year?,
        completionHandler: @escaping PopulationDataResultBlock
    ) {
        networkManager.request(
            endpoint: .data(location, year),
            completionHandler: completionHandler
        )
    }
}

final class PopulationService {

    var networkManager: NetworkManagerProtocol

    init(service: NetworkManagerProtocol) {
        self.networkManager = service
    }
}
