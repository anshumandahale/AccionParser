//
//  DetailModelTest.swift
//  AccionParserTests
//
//  Created by Anshuman Dahale on 20/11/22.
//

import XCTest
@testable import AccionParser

class DetailModelTest: XCTest {
    var mockItem: Item?
    var resultString: String?
    var detailVM: DetailViewModel?
    
    override func setUp() async throws {
        let tags = ["India", "Nepal", "Bhutan"]
        let mockItem = Item(tags: tags, owner: nil, isAnswered: nil, viewCount: nil, answerCount: nil, score: nil, lastActivityDate: nil, creationDate: nil, questionID: nil, contentLicense: nil, link: nil, title: nil, acceptedAnswerID: nil, lastEditDate: nil, closedDate: nil, closedReason: nil)
        detailVM = DetailViewModel(item: mockItem)
        detailVM?.outputDelegate = self
    }
    
    func testThatWhenWeSupplyStringsArrayWeGetAUniqueString() {
        XCTAssertNil(self.resultString)
        detailVM?.viewLoaded()
        XCTAssertNotNil(self.resultString)
    }
}

extension DetailModelTest: DetailViewModelOutput {
    func showItemDetails(tags: String) {
        self.resultString = tags
    }
}
