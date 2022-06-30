//
//  DailyView.swift
//  Clima
//
//  Created by Paul Kirnoz on 29.06.2022.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
        ForEach(cityVM.weather.daily) { weather in
            LazyVStack {
                    dailyCell(weather: weather)
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 4, alignment: .leading)
                        .opacity(0.1)
                    Spacer()
                }
                .padding(.leading, 20)
                }
            }
        }
    }
    
    private func dailyCell(weather: DailyWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt))
                .font(.custom("Montserrat-Regular", size: 20))
                .frame(width: 50)
                .padding()
            
            Spacer()
            
            cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
                .font(.title)
                .foregroundColor(Color("main"))
            
            Spacer()
            
            Text("\(cityVM.getTempFor(temp: weather.temp.max)) | \(cityVM.getTempFor(temp: weather.temp.min)) °")
                .font(.custom("Montserrat-Regular", size: 20))
                .frame(width: 110)
            
        }
        .padding([.leading, .trailing])
        
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
