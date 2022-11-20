//
//  MockAppCoordinator.swift
//  AccionParserTests
//
//  Created by Anshuman Dahale on 20/11/22.
//

import Foundation
@testable import AccionParser

enum Route {
    case toDetail
}

class MockAppCoordinator: AppCoordinatorProtocol {
    var calledRoute: Route?
    func navigateToDetail(item: AccionParser.Item) {
        calledRoute = .toDetail
    }
}
