//
//  PopulationListViewModelTests.swift
//  PopulationListViewModelTests
//
//  Created by Marcos Vicente on 14/11/2024.
//

import XCTest
import Combine
@testable import Populus

final class PopulationListViewModelTests: XCTestCase {

    var sut: PopulationListViewModel!
    var mockedService: MockPopulationService!
    var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        subscriptions = Set<AnyCancellable>()
        mockedService = MockPopulationService()
        sut = PopulationListViewModel(
            service: mockedService
        )
    }

    override func tearDownWithError() throws {
        subscriptions = nil
        mockedService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchPopulationDataShouldReturnDataWithSuccess() {
        // given
        let dummyResponse: PopulationDataResponse = .dummy
        let expectedResponse: [PopulationDataViewModel] = Parser.generateViewModel(from: dummyResponse.data)
        mockedService.result = .success(dummyResponse)
        var receivedResponse: [PopulationDataViewModel] = []
        let expectation = XCTestExpectation(description: "Data successfully fetched")

        // when
        sut.$populationData
            .dropFirst()
            .sink { response in
                receivedResponse = response
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        sut.fetchData()

        wait(for: [expectation], timeout: 1)

        // then
        XCTAssertEqual(receivedResponse, expectedResponse)
    }

    func testFetchPopulationDataShouldFailToReturnData() {
        // given
        let expectedResponse: NetworkError = .badRequest
        mockedService.result = .failure(expectedResponse)
        var receivedResponse: String = .init()
        let expectation = XCTestExpectation(description: "Data fetched with error")

        // when
        sut.$errorDescription
            .dropFirst()
            .sink { response in
                receivedResponse = response.description
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        sut.fetchData()

        wait(for: [expectation], timeout: 1)

        //then
        XCTAssertEqual(receivedResponse, expectedResponse.description)
    }

    func testSetYear() {
        // given
        let expectedLocation: Year = .latest
        sut.setSubscribers()
        var receivedResponse: [Year] = []
        let expectation = XCTestExpectation(description: "Year parameter was set")

        // when
        sut.$year
            .dropFirst()
            .sink { response in
                receivedResponse.append(response)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        sut.year = expectedLocation

        wait(for: [expectation], timeout: 1)

        // then
        XCTAssertEqual(receivedResponse[0], expectedLocation)
    }

    func testFetchPopulationDataShouldSetLocation() {
        // given
        let expectedLocation: LocationType = .state
        let dummyResponse: PopulationDataResponse = .init(data: PopulationDataResponse.dummy.data.filter {
            if expectedLocation == .nation {
                return $0.nation != nil
            }
            return $0.state != nil
        })

        let expectedResponse: [PopulationDataViewModel] = Parser.generateViewModel(from: dummyResponse.data)
        mockedService.result = .success(dummyResponse)
        var receivedResponse: [PopulationDataViewModel] = []
        let expectation = XCTestExpectation(description: "Data with set location successfully set")

        // when
        sut.$populationData
            .dropFirst()
            .sink { response in
                receivedResponse = response
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        sut.location = expectedLocation

        wait(for: [expectation], timeout: 1)

        // then
        XCTAssertEqual(receivedResponse, expectedResponse)
    }
}
