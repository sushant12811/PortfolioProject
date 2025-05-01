//
//  Extension.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//
import Foundation

    
extension Double {
    func convertToCelsius() -> String {
        let celsius = self - 273.15
        return String(format: "%.f", celsius)
    }
}


func getWeatherIconSymbol(for id: Int) -> String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain.fill"   
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "questionmark.circle.fill"
        }
    }



