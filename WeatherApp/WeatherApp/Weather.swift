//
//  Weather.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-29.
//
import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
    let humidity : Int
}

