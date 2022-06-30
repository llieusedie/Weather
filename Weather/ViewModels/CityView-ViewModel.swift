//
//  CityView-ViewModel.swift
//  Clima
//
//  Created by Paul Kirnoz on 20.06.2022.
//

import SwiftUI
import CoreLocation
///instances monitor changes in this class according to ObservableObject
final class CityViewViewModel: ObservableObject {
    
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "San Francisco" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocation()
    }
    
    ///return a formatted date
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sunny"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    func getTimeFor(timeStamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    ///get location for a certain place
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    ///function to get the lat and lot for the address
    private func  getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
            
        } else {
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9886)
            
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    ///func to get the weather information.
    ///Place where network calls are done
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
                
            case .success(let response) :
                
                DispatchQueue.main.async {
                    self.weather = response
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func getLottieAnimationFor(icon: String) -> String {
        withAnimation(.spring()) {
            switch icon {
            case "01d" :
                return "sunnyDay"
            case "01n" :
                return "clearNight"
            case "02d" :
                return "cloudyDayNight"
            case "03d" :
                return "cloudyDayNight"
            case "04d" :
                return "cloudyDayNight.json"
            case "02n" :
                return "cloudyNight"
            case "03n" :
                return "cloudyNight"
            case "04n" :
                return "cloudyNight"
            case "09d" :
                return "rainDay"
            case "10d" :
                return "rainDay"
            case "09n" :
                return "RainNight"
            case "10n" :
                return "RainNight"
            case "11d" :
                return "stormDay"
            case "11n" :
                return "stormDayNight"
            case "13d" :
                return "snowDay"
            case "13n" :
                return "snowNight"
            case "50d" :
                return "mistDayNight"
            case "50n" :
                return "mistDayNight"
            default :
                return "sunnyDay"
            }
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.moon.fill")
        case "03d" :
            return Image(systemName: "cloud.fill")
        case "03n" :
            return Image(systemName: "cloud.fill")
        case "04d":
            return Image(systemName: "cloud.fill")
        case "04n":
            return Image(systemName: "cloud.fill")
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d":
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d":
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default :
            return Image(systemName: "sun.max.fill")
        }
    }
    
    func getBackgroundColorFor(hour: String) -> Color {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 1:
            return Color.red
        case 2:
            return Color.red
        case 3:
            return Color.red
        case 4:
            return Color.red
        case 5:
            return Color.red
        case 6:
            return Color.red
        case 7:
            return Color.red
        case 8:
            return Color.red
        case 9:
            return Color.red
        case 10:
            return Color.red
        case 11:
            return Color.red
        case 12:
            return Color.teal
        case 13:
            return Color.teal
        case 14:
            return Color.teal
        case 15:
            return Color.teal
        case 16:
            return Color.brown
        case 17:
            return Color.teal
        case 18:
            return Color.gray
        case 19:
            return Color.pink
        case 20:
            return Color.green
        case 21:
            return Color.yellow
        case 22:
            return Color.black
        case 23:
            return Color.blue
        case 24:
            return Color.purple
        default:
            return Color.pink
        }
    }
}

