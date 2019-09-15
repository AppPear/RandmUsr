//
//  DetailUserView.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 14..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI
import URLImage
struct DetailUserView: View {
    var user: User
    
    var body: some View {
        ScrollView{
            VStack{
                ProfilePicture(imageURL: user.picture.large)
                PersonalInfoView(user: user)
                AddressView(user: user)
                LocationInfoView(user: user)
            }.padding()
        }.navigationBarTitle("\(user.name.first.capitalized) \(user.name.last.capitalized)", displayMode: .inline)
    }
}

struct ProfilePicture: View {
    var imageURL: String
    var body: some View {
        URLImage(URL(string:imageURL)!)
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(Color.white, style: StrokeStyle(lineWidth: 3)))
            .frame(width: 160, height: 160)
            .shadow(color: Color(white: 0.75), radius: 16, y: 6)
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailUserView(user: TestData.user)
        }
    }
}


