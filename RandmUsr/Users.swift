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

    var list: [User] = [User]()
    var info: UserInfo? = nil
    var currentPage: Int = 0
    let defaultResultNumber:Int = 16
    
    func getNextPage() {
        getUserListFromAPI(result: defaultResultNumber, page: currentPage + 1)
        currentPage += 1
    }
    
    func getUserListFromAPI(result: Int, page: Int) {
        do {
            let request = try RandomUserAPI.getUsers(result: result, page: page).asURLRequest()
            
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
    
}
