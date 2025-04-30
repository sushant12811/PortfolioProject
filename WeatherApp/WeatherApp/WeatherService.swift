//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-29.
//

import Foundation
import SwiftUI

class WeatherService {
    
    static let shared = WeatherService()

    let apiKey = "406873bf744ce97d89ab71327c91d6d1"
    
    func fetchWeather(cityName : String) async throws -> WeatherResponse{
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
            let (data, response) =  try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse{
                print("Http Status Code: \(httpResponse)")
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(WeatherResponse.self, from: data)
    }
    private init(){}
}
