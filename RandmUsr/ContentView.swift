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
        NavigationView{
            List{
                ForEach(self.users.list, id: \.phone) { user in
                    NavigationLink(destination: DetailUserView(user: user)){
                        UserCell(user: user)
                    }
                }
                Text("loading")
                    .onAppear {
                        self.users.getNextPage()
                }
            }
            .navigationBarTitle(Text("Random users"))
            .navigationBarItems(trailing: Button(action: {
                print("filter")
            }){
                Image(systemName: "line.horizontal.3.decrease.circle").imageScale(.large)
            })
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .onAppear {
            self.users.getNextPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
