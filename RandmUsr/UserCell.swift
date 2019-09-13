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
            URLImage(URL(string: user.picture.medium)!, configuration: ImageLoaderConfiguration(delay: 0.25))
                .resizable()
                .frame(width: 60.0, height: 60)
                .clipShape(Circle())
                .padding([.trailing])
                .animation(.spring())
            VStack(alignment: .leading){
                Text("\(user.name.first) \(user.name.last)").font(.headline)
                Text("\(user.email)").font(.callout)
            }
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: TestData.user)
    }
}
