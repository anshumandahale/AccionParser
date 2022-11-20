//
//  AppCoordinator.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 17/11/22.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol]? { get }
    
    func start()
}

protocol AppCoordinatorProtocol {
    func navigateToDetail(item: Item)
}

class AppCoordinator: CoordinatorProtocol, AppCoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userService = UserService()
        let landingVM = LandingViewModel(router: self, userService: userService)
        let landingVC = LandingViewController(nibName: "LandingViewController",
                                              viewModel: landingVM)
        self.navigationController.pushViewController(landingVC, animated: true)
    }
    
    func navigateToDetail(item: Item) {
        let detailVM = DetailViewModel(item: item)
        let detailVC = DetailViewController(viewModel: detailVM, nib: "DetailViewController")
        self.navigationController.pushViewController(detailVC, animated: true)
    }
}
