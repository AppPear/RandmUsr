//
//  RandomUserAPI.swift
//  RandomAPI
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import Foundation

enum RandomUserAPI {
    case getUsers(result: Int, page: Int)
    case getUsersByGender(result: Int, page: Int, gender: UserGender)
    case getUsersByNationality(result: Int, page: Int, nationality: String)
    
    var path: URL? {
        switch self {
        case .getUsers(let result, let page):
            let queryItemResult = URLQueryItem(name: "results", value: String(result))
            let queryItemPage = URLQueryItem(name: "page", value: String(page))
            return URLComponents.APIUrl(with: [queryItemResult, queryItemPage])
        case .getUsersByGender(let result, let page, let gender):
            let queryItemResult = URLQueryItem(name: "results", value: String(result))
            let queryItemPage = URLQueryItem(name: "page", value: String(page))
            let queryItemGender = URLQueryItem(name: "gender", value:  gender.rawValue)
            return URLComponents.APIUrl(with: [queryItemResult, queryItemPage, queryItemGender])
        case .getUsersByNationality(let result, let page, let nationality):
            let queryItemResult = URLQueryItem(name: "results", value: String(result))
            let queryItemPage = URLQueryItem(name: "page", value: String(page))
            let queryItemNationality = URLQueryItem(name: "nat", value:  nationality)
            return URLComponents.APIUrl(with: [queryItemResult, queryItemPage, queryItemNationality])
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let path = self.path else {
            throw APIError.pathNotValid
        }
        
        return URLRequest(url: path)
    }
}

extension URLComponents {
    static func APIUrl(with items: [URLQueryItem]) -> URL? {
        let seed = URLQueryItem(name: "seed", value: "abc")
        let exclude = URLQueryItem(name: "exc", value: "login,id")

        var itemsWithSeed = items
        itemsWithSeed.append(seed)
        itemsWithSeed.append(exclude)

        var components = URLComponents()
        components.scheme = "https"
        components.host = "randomuser.me"
        components.path = "/api"
        components.queryItems = itemsWithSeed
        return components.url
    }
}

enum APIError: Error {
    case pathNotValid
    case emptyResponseBody
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .pathNotValid:
            return "Path not valid"
        case .emptyResponseBody:
            return "Empty response body"
        }
    }
}
