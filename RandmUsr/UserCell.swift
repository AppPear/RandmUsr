//
//  UserCell.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI
import URLImage

struct UserCell: View {
    var user: User
    var body: some View {
        HStack{
            URLImage(URL(string: user.picture.medium)!, configuration: ImageLoaderConfiguration(delay: 0, useInMemoryCache: true))
                .resizable()
                .frame(width: 60.0, height: 60)
                .clipShape(Circle())
                .padding([.trailing])
                .shadow(color: Color(white: 0.66), radius: 8)
            VStack(alignment: .leading){
                Text("\(user.name.first.capitalized) \(user.name.last.capitalized)").font(.headline).padding(.bottom, 4)
                Text("\(user.email)").font(.footnote).foregroundColor(Color.gray)
            }
        }.padding([.top, .bottom], 6)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: TestData.user)
    }
}
