//
//  Users.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import Foundation
import Combine

class Users: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    var seed: String = "sdadadfadfs"
    var list: [User] = [User]()
    var info: UserInfo? = nil
    var currentPage: Int = 0
    let defaultResultNumber:Int = 16
    
    func getNextPage() {
        getUserListFromAPI(result: defaultResultNumber, page: currentPage + 1, seed: self.seed)
        currentPage += 1
    }
    
    func refreshFeed() {
        self.list.removeAll()
        self.currentPage = 0
        self.seed = randomString(length: 8)
        self.getNextPage()
    }
    
    func getUserListFromAPI(result: Int, page: Int, seed: String) {
        do {
            let request = try RandomUserAPI.getUsers(result: result, page: page, seed: seed).asURLRequest()
            
            let completionHandler: (Data?, URLResponse?, Error?) -> Void = { [weak self] (data, response, error) in
               guard let strongSelf = self else { return }
                if let error = error {
                   print("Error: ", error.localizedDescription)
                } else {
                    if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(UserList.self, from: data)
                            strongSelf.info = decodedData.info
                            strongSelf.list.append(contentsOf: decodedData.results)
                            DispatchQueue.main.async {
                                strongSelf.objectWillChange.send()
                            }
                        } catch {
                           print(error)
                        }
                    } else {
                       print(APIError.emptyResponseBody.localizedDescription)
                    }
                }
            }
            
            URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
