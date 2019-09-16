//
//  Spinner.swift
//  PullToRefresh
//
//  Created by András Samu on 2019. 09. 15..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct Spinner: View {
    @Binding var percentage: CGFloat
    var body: some View {
        GeometryReader{ geometry in
            ForEach(1...10, id: \.self) { i in
                Rectangle()
                    .fill(Color.gray)
                    .cornerRadius(1)
                    .frame(width: 2.5, height: 8)
                    .opacity(self.percentage * 10 >= CGFloat(i) ? Double(i)/10.0 : 0)
                    .offset(x: 0, y: -8)
                    .rotationEffect(.degrees(Double(36 * i)), anchor: .bottom)
            }.offset(x: 20, y: 12)
        }.frame(width: 40, height: 40)
    }
}

struct RefreshView: View {
    @Binding var isRefreshing:Bool
    @Binding var status: CGFloat
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .center){
                if (!isRefreshing) {
                    Spinner(percentage: $status)
                }else{
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                Text(isRefreshing ? "Loading" : "Pull to refresh").font(.caption)
                    .opacity(Double(self.status))
            }
            Spacer()
        }
    }
}

struct PullToRefreshView: View {
    @Binding var showRefreshView: Bool
    @Binding var pullStatus: CGFloat
    var body: some View {
        GeometryReader{ geometry in
            RefreshView(isRefreshing: self.$showRefreshView, status: self.$pullStatus)
                .preference(key: RefreshableKeyTypes.PrefKey.self, value: [RefreshableKeyTypes.PrefData(bounds: geometry.frame(in: CoordinateSpace.global))])
                .offset(x: 0, y: -90)
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct RefreshableKeyTypes {
    
    struct PrefData: Equatable {
        let bounds: CGRect
    }
    
    struct PrefKey: PreferenceKey {
        static var defaultValue: [PrefData] = []
        
        static func reduce(value: inout [PrefData], nextValue: () -> [PrefData]) {
            value.append(contentsOf: nextValue())
        }
        
        typealias Value = [PrefData]
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
//            Spinner(percentage: .constant(1))
            PullToRefreshView(showRefreshView: .constant(false), pullStatus: .constant(1))
        }
        
    }
}
