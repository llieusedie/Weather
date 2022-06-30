//
//  DetailsView.swift
//  Clima
//
//  Created by Paul Kirnoz on 29.06.2022.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var cityVM: CityViewViewModel
    var body: some View {
        HStack {
            widgetView(image: "humidity", title: "\(cityVM.humidity)")
            Spacer()
            widgetView(image: "wind", title: "\(cityVM.windSpeed)km/h")
            Spacer()
            widgetView(image: "umbrella", title: "\(cityVM.rainChances)")
        }
        .font(.custom("Montserrat-Regular", size: 20))
        
        .padding([.trailing, .leading], 40)
    }
    private func widgetView(image: String, title: String) -> some View {
        
        VStack(spacing: -1) {
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(Color("main"))

            Text(title)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    @ObservedObject var cityVM: CityViewViewModel
    static var previews: some View {
        ContentView()
    }
}
