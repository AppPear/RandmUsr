//
//  ContentView.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 13..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var users = Users()
    var body: some View {
        VStack{
            List{
                ForEach(self.users.list, id: \.phone) { user in
                    UserCell(user: user)
                }
            }
        }.onAppear {
            self.users.getNextPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
