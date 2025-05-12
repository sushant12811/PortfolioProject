//
//  Weather.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-29.
//
import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let humidity : Int
    let tempMin: Double
    let tempMax: Double
    
}

struct Weather: Decodable {
        let id: Int
        let description: String
        let icon: String
    }

struct Wind: Decodable{
    let gust: Double
}

//MARK: Structure- Domain Model: Make easy for accessing
struct DomainWeatherModel{
    let id: Int
    let cityName: String
    let temperature: Double
    let icon: String
    let description: String
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windGust: Double
    let humidity: Int

}






