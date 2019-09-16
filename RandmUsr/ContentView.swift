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
    @State var showRefreshView: Bool = false
    @State var pullStatus: CGFloat = 0
    var body: some View {
        NavigationView{
            List{
                PullToRefreshView(showRefreshView: $showRefreshView, pullStatus: $pullStatus)
                ForEach(self.users.list, id: \.phone) { user in
                    NavigationLink(destination: DetailUserView(user: user)){
                        UserCell(user: user)
                    }
                }
                Text("loading...")
                    .onAppear {
                        self.users.getNextPage()
                }
            }
            .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
                guard let bounds = values.first?.bounds else { return }
                self.pullStatus = CGFloat((bounds.origin.y - 106) / 80)
                self.refresh(offset: bounds.origin.y)
            }.offset(x: 0, y: -40)
                .navigationBarTitle(Text("Random users"))
                .navigationBarItems(trailing: Button(action: {
                    print("filter")
                }){
                    Image(systemName: "line.horizontal.3.decrease.circle").imageScale(.large)
                })
        }
        .offset(x: 0, y: self.showRefreshView ? 34 : 0)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .onAppear {
            self.users.getNextPage()
            UITableView.appearance().separatorColor = .clear
        }
    }
    
    func refresh(offset: CGFloat) {
         if(offset > 185 && self.showRefreshView == false) {
             self.showRefreshView = true
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.users.refreshFeed()
                self.showRefreshView = false
             }
         }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
