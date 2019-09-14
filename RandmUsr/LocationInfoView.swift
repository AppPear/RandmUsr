//
//  LocationInfoView.swift
//  RandmUsr
//
//  Created by András Samu on 2019. 09. 14..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI
import MapKit

struct LocationInfoView: View {
    var user: User
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude:Double(user.location.coordinates.latitude)!,
            longitude: Double(user.location.coordinates.longitude)!
        )
    }
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(white:0.9), radius: 16)
                MapView(coordinate: coordinate)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.white)
                            
                        HStack{
                            VStack(alignment: .leading){
                                Text("Address:").bold()
                                SmallCell(firstCol: "Street: ", secondCol: user.location.street.capitalized)
                                SmallCell(firstCol: "City: ", secondCol:" \(user.location.postcode)  \(user.location.city.capitalized)")
                                SmallCell(firstCol: "State: ", secondCol: user.location.state.capitalized)
                                Spacer()
                            }.padding()
                        }
                    }.padding()
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                }
            }.frame(maxHeight: .infinity)
        }.padding()
    }
}

struct SmallCell: View {
    var firstCol: String
    var secondCol: String
    var body: some View {
        HStack{
            Text(firstCol)
            Text(secondCol).font(.footnote).bold()
            Spacer()
        }.padding(.bottom, 2)
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(user: TestData.user)
    }
}
