//
//  LandingViewModel.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 17/11/22.
//

//https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow

import Foundation

protocol ViewModelType {
    
}

protocol LandingViewModelProtocol {
    var outputDelegate: LandingViewModelOutput? { get set }
    func loadData()
    func showDetail(item: Item)
}

protocol LandingViewModelOutput {
    func recievedData(user: User)
    func failedToLoadUserData(error: Error)
}

class LandingViewModel<Router: AppCoordinatorProtocol>: LandingViewModelProtocol, ViewModelType {
    var outputDelegate: LandingViewModelOutput?
    var coordinator: Router
    var userService: UserServiceProtocol
    
    func loadData() {
        userService.getUserData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self.outputDelegate?.recievedData(user: user)
            case .failure(let err):
                self.outputDelegate?.failedToLoadUserData(error: err)
            }
        }
    }
    
    func showDetail(item: Item) {
        coordinator.navigateToDetail(item: item)
    }
    
    init(router: Router, userService: UserServiceProtocol) {
        self.coordinator = router
        self.userService = userService
    }
}
