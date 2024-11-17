//
//  MockPopulationService.swift
//  PopulusTests
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation
@testable import Populus

final class MockPopulationService: PopulationServiceProtocol {

    var result: Result<PopulationDataResponse, NetworkError>?

    func requestPopulationData(
        at location: LocationType,
        on year: Year?,
        completionHandler: @escaping PopulationDataResultBlock
    ) {
        if let result {
            completionHandler(result)
        }
    }
}
