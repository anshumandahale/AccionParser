//
//  UserService.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 18/11/22.
//

import Foundation

protocol UserServiceProtocol {
    func getUserData(completion: @escaping (Result<User?, Error>) -> Void)
}

class UserService: UserServiceProtocol {
    func getUserData(completion: @escaping (Result<User?, Error>) -> Void) {
        let manager = NetworkManager()
        let request = Requester().getUserRequest()
        manager
            .performRequest(request: request) { (result: Result<User, Error>) in
                switch result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

private enum Constant {
    static let url: String = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow"
}
