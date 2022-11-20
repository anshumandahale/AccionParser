//
//  MockUserService.swift
//  AccionParserTests
//
//  Created by Anshuman Dahale on 20/11/22.
//

import Foundation
@testable import AccionParser

class MockUserServiceSuccess: UserServiceProtocol {
    func getUserData(completion: @escaping (Result<AccionParser.User?, Error>) -> Void) {
        do {
            guard let urlPath = Bundle.main.url(forResource: "user", withExtension: "json") else { return }
            let data = try Data(contentsOf: urlPath, options: .mappedIfSafe)
            let user = try JSONDecoder().decode(User.self, from: data)
            completion(.success(user))
        }
        catch {
            completion(.failure(ManagerErrors.invalidResponse))
        }
    }
}

class MockUserServiceFailure: UserServiceProtocol {
    func getUserData(completion: @escaping (Result<User?, Error>) -> Void) {
        completion(.failure(ManagerErrors.invalidResponse))
    }
}
