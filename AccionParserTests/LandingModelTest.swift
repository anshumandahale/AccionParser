//
//  AccionParserTests.swift
//  AccionParserTests
//
//  Created by Anshuman Dahale on 20/11/22.
//

import XCTest
@testable import AccionParser

final class LandingModelTest: XCTestCase {

    let mockAppCoordinator = MockAppCoordinator()
    let mockUserServiceSuccess = MockUserServiceSuccess()
    let mockUserServiceFailure = MockUserServiceFailure()
    var user: User?
    var err: Error?
    
    func testThatWhenLandingViewLoadsModelFetchesDataAndFeedsTheViewControllerAUserObject() {
        XCTAssertNil(self.user)
        let expectation = expectation(description: #function)
        let landingVM = LandingViewModel(router: mockAppCoordinator,
                                         userService: mockUserServiceSuccess)
        landingVM.outputDelegate = self
        landingVM.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(self.user)
    }
    
    func testThatWhenUserSelectsAndItemHeIsNavigatedToTheDetailView() {
        XCTAssertNil(mockAppCoordinator.calledRoute)
        let expectation = expectation(description: "expectation")
        let landingVM = LandingViewModel(router: mockAppCoordinator,
                                         userService: mockUserServiceSuccess)
        landingVM.outputDelegate = self
        
        let mockItem = Item(tags: nil, owner: nil, isAnswered: nil, viewCount: nil, answerCount: nil, score: nil, lastActivityDate: nil, creationDate: nil, questionID: nil, contentLicense: nil, link: nil, title: nil, acceptedAnswerID: nil, lastEditDate: nil, closedDate: nil, closedReason: nil)
        landingVM.showDetail(item: mockItem)
        XCTAssertEqual(mockAppCoordinator.calledRoute, .toDetail)
    }
    
    func testThatWhenServiceCallFailsWeGetAnError() {
        XCTAssertNil(self.err)
        let landingVM = LandingViewModel(router: mockAppCoordinator,
                                         userService: <#T##UserServiceProtocol#>)
    }
}

extension LandingModelTest: LandingViewModelOutput {
    func recievedData(user: AccionParser.User) {
        self.user = user
    }
    
    func failedToLoadUserData(error: Error) {
        self.err = error
    }
}
