//
//  PersonalInfoView.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 14..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct PersonalInfoView: View {
    var user: User
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(white:0.9), radius: 16)
                VStack(alignment: .leading){
                    Cell(firstCol: "Full name: ", secondCol: "\(user.name.first.capitalized) \(user.name.last.capitalized)")
                    Cell(firstCol: "Nationality: ", secondCol: user.nat)
                    Cell(firstCol: "Date of birth: ", secondCol: formatDate(dateString: user.dob.date))
                    Cell(firstCol: "Email: ", secondCol: user.email)
                    Cell(firstCol: "Phone: ", secondCol: user.phone)
                    Cell(firstCol: "Cell: ", secondCol: user.cell)
                    Cell(firstCol: "Date of registration: ", secondCol: formatDate(dateString: user.registered.date))
                    Spacer()
                }.padding()
            }.padding()
            Spacer()
        }
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        
        let newFormat = DateFormatter()
        newFormat.dateFormat = "dd/MM/yyyy"
        return newFormat.string(from: date!)
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView(user: TestData.user)
    }
}

struct Cell: View {
    var firstCol: String
    var secondCol: String
    var body: some View {
        HStack{
            Text(firstCol)
            Text(secondCol).font(.headline)
            Spacer()
        }.padding(.bottom, 6)
    }
}
