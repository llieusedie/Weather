//
//  API-Extensiosn.swift
//  Clima
//
//  Created by Paul Kirnoz on 20.06.2022.
//

import Foundation

extension API {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    ///made to construct the url for the request
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(baseURLString)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)&units=metric"
    }
}
