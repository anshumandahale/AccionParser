//
//  UserRequester.swift
//  AccionParser
//
//  Created by Anshuman Dahale on 20/11/22.
//

import Foundation

protocol RequestorProtocol {
    func getUserRequest() -> URLRequest
}

enum HTTPMethodType {
    static let get = "GET"
    static let post = "POST"
}

class Requester: RequestorProtocol {
    func getUserRequest() -> URLRequest {
        let url = URL(string: Constant.url)!
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadRevalidatingCacheData,
                                 timeoutInterval: 30.0)
        request.httpMethod = HTTPMethodType.get
        return request
    }
}

private enum Constant {
    static let url: String = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow"
}
