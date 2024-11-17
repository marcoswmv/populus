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

    func testFetchPopulationDataWithSuccess() {
        // given
        let dummyResponse: PopulationDataResponse = mockedService.response
        let expectedResponse: [PopulationDataViewModel] = Parser.generateViewModel(from: dummyResponse.data)
        let expectation = XCTestExpectation(description: "Data successfully fetched")

        // when
        sut.$populationData
            .dropFirst()
            .sink { [weak self] response in
                guard let self else { return }
                XCTAssertEqual(response, expectedResponse)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        sut.fetchData()

        // then
        wait(for: [expectation], timeout: 5)
    }

    func testRequestDataFromMockedPopulationService() {
        //given
        let expectedDummyResponse: PopulationDataResponse = mockedService.response
        let expectation = XCTestExpectation(description: "Data successfully fetched")

        //when
        mockedService.requestPopulationData(at: .nation, on: .all) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, expectedDummyResponse)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 5)
    }

    func testFetchPopulationDataWithFailure() {
        // given
        mockedService.error = .badRequest

        // when
        sut.fetchData()

        // when
//        XCTAssertEqual(sut.errorDescription, NetworkError.badRequest.description)
    }
}
