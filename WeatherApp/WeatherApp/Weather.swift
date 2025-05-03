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
}

struct Main: Decodable {
    let temp: Double
    let humidity : Int
}

struct Weather: Decodable {
        let id: Int
        let description: String
        let icon: String
    }

//MARK: Structure- Domain Model: Make easy for accessing
struct DomainWeatherModel{
    let cityName: String
    let temperature: Double
    let humidity: Int
    let icon: String
    let id: Int
    let description: String
}






