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
    @State var selectorIndex: Int = 0
    var body: some View {
        VStack{
            VStack{
                ProfilePicture(imageURL: user.picture.large)
                Text("\(user.name.first.capitalized) \(user.name.last.capitalized)").font(.headline)
                Text("\(user.location.city.capitalized), \(user.dob.age)").font(.footnote).foregroundColor(Color.gray)
            }.padding()
            
            Picker(selection: $selectorIndex, label: Text("What is your favorite color?")) {
                Text("Personal info").tag(0)
                Text("Location").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if (self.selectorIndex == 0) {
                PersonalInfoView(user: user)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    .animation(.easeOut)
            }else{
                LocationInfoView(user: user)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.easeOut)
            }
            Spacer(minLength: 0)
        }
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: TestData.user)
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
