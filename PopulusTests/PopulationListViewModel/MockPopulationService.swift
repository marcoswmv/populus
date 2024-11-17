//
//  MockPopulationService.swift
//  PopulusTests
//
//  Created by Marcos Vicente on 16/11/2024.
//

import Foundation
@testable import Populus

final class MockPopulationService: PopulationServiceProtocol {

    var response: PopulationDataResponse = .init(data: [])
    var error: NetworkError?

    func requestPopulationData(
        at location: LocationType,
        on year: Year?,
        completionHandler: @escaping PopulationDataResultBlock
    ) {
        if let error {
            completionHandler(.failure(error))
        } else {
            response = .init(data: PopulationDataResponse.dummy.data
                .filter {
                    data in
                    if location == .nation {
                        return data.nation != nil
                    }
                    return data.state != nil
                })
            completionHandler(.success(response))
        }
    }
}
