//
//  Extension.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//
import Foundation
import SwiftUI
import SpriteKit

    
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


func getBackground(for id: Int) -> AnyView {
    switch id {
    case 200...232:
        return AnyView(Image(.thunder).resizable().scaledToFill())
    case 300...321:
        return AnyView(WeatherView(emitterFile: "Rain.sks"))
    case 500...531:
        return AnyView(WeatherView(emitterFile: "Rain.sks"))
    case 600...622:
        return AnyView(WeatherView(emitterFile: "Snow.sks"))
    case 701...781:
        return AnyView(Image(.cloudFog).resizable().scaledToFill())
    case 800:
        return AnyView(Image(.sunny).resizable().scaledToFill())
    case 801...804:
        return AnyView(Image(.cloudy).resizable().scaledToFill())
    default:
        return AnyView(Color.backGround1)
    }
}

    




