//
//  UserModel.swift
//  RandomAPI
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import Foundation

struct UserList: Codable {
    var results:[User]
    var info: UserInfo
}

struct User: Codable {
//    var id = UUID()
    var gender: String
    var name: UserName
    var location: UserLocation
    var email: String
    var dob: UserDoB
    var registered: UserDoB
    var phone: String
    var cell: String
    var picture: UserPicture
    var nat: String
}

enum UserGender: String, Codable{
    case male
    case female
}

struct UserName:Codable{
    var title: String
    var first: String
    var last: String
}

struct UserLocation: Codable{
    var street: String
    var city: String
    var state: String
    var postcode: AnyCodable
    var coordinates: UserCoordinate
    var timezone: UserTimezone
}

struct UserCoordinate: Codable {
    var latitude: String
    var longitude: String
}

struct UserTimezone: Codable {
    var offset: String
    var description: String
}

struct UserDoB: Codable{
    var date:String
    var age:Int
}

struct UserPicture: Codable{
    var large:String
    var medium:String
    var thumbnail:String
}

struct UserInfo: Codable{
    var seed: String
    var results: Int
    var page: Int
    var version: String
}
