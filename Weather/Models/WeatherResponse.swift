//
//  WeatherResponse.swift
//  Clima
//
//  Created by Paul Kirnoz on 20.06.2022.
//

import Foundation


struct WeatherResponse: Codable {
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
    ///creates instances for each hour weather data (23 hours)
    ///creates instances for each day weather data (8 days)
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
}
