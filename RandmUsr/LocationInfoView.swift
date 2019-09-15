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
        
        MapView(coordinate: coordinate)
            .frame(minHeight: 240)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color(white:0.9), radius: 16)
            .padding()
        
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
        }.padding(.bottom, 6)
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var pin: MKPointAnnotation {
        let mapPin = MKPointAnnotation()
        mapPin.coordinate = coordinate
        return mapPin
    }
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        view.addAnnotation(pin)
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(user: TestData.user)
    }
}

struct AddressView: View {
    var user: User
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)
                    .shadow(color: Color(white:0.9), radius: 16)
                HStack{
                    VStack(alignment: .leading){
                        Text("Address:").bold().padding(.bottom)
                        SmallCell(firstCol: "Street: ", secondCol: user.location.street.capitalized)
                        SmallCell(firstCol: "City: ", secondCol:" \(user.location.postcode)  \(user.location.city.capitalized)")
                        SmallCell(firstCol: "State: ", secondCol: user.location.state.capitalized)
                        Spacer()
                    }.padding()
                }
            }.padding()
            Spacer(minLength: 0)
        }
    }
}
