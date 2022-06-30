//
//  TodayHourlyView.swift
//  Clima
//
//  Created by Paul Kirnoz on 29.06.2022.
//

import SwiftUI

struct TodayHourlyView: View {
    @ObservedObject var cityVM: CityViewViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(cityVM.weather.hourly) { weather in

                    let icon = cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
                    
                    let hour = cityVM.getTimeFor(timeStamp: weather.dt)
                    
                    let temp = cityVM.getTempFor(temp: weather.temp)
                    
                    getHourlyView(hour: (hour), image: icon, temp: temp)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 3, height: 40, alignment: .center)
                        .opacity(0.1)
                }
            }
        }
    }
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 20) {
            Text(hour)
                .font(.custom("Montserrat-Regular", size: 20))
            
            image
                .font(.title)
                .foregroundColor(Color("main"))
                
            Text("\(temp) °")
                .font(.custom("Montserrat-Regular", size: 20))
        }
        .padding()
    }
}

struct TodayHourlyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
