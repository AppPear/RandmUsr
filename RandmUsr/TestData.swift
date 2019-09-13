//
//  TestData.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import Foundation

class TestData {
    static var user = User(gender: "female", name: UserName(title: "miss", first: "louane", last: "vidal"), location: UserLocation(street: "2479 place du 8 février 1962", city: "avignon", state: "vendée", postcode: AnyCodable(78276), coordinates: UserCoordinate(latitude: "2.0565", longitude: "95.2422"), timezone: UserTimezone(offset: "+1:00", description: "Brussels, Copenhagen, Madrid, Paris")), email: "louane.vidal@example.com", dob: UserDoB(date: "1965-12-20T13:32:15Z", age: 53), registered: UserDoB(date: "2015-07-25T23:14:54Z", age: 4), phone: "02-62-35-18-98", cell: "06-07-80-83-11", picture: UserPicture(large: "https://randomuser.me/api/portraits/women/88.jpg", medium: "https://randomuser.me/api/portraits/med/women/88.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/88.jpg"), nat: "FR")
}
