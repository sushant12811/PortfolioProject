//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var weather: DomainWeatherModel?
    
    func loadWeather(name: String) async {
        do{
            let weatherResponse = try await WeatherService.shared.fetchWeather(cityName: name)
            let weatherData = DomainWeatherModel(
                cityName: weatherResponse.name,
                temperature: weatherResponse.main.temp,
                humidity: weatherResponse.main.humidity,
                icon: weatherResponse.weather.first?.icon ?? "photo",
                id: weatherResponse.weather.first?.id ?? 0,
                description: weatherResponse.weather.first?.description ?? "No Description"
                
            )
            await MainActor.run {
                self.weather = weatherData
            }
            
            
            
        }catch{
            print("Error Loading Weather : \(error.localizedDescription)")
        }
    }
    
    func loadWeather(lat: Double, lon: Double) async {
        do {
            let weatherResponse = try await WeatherService.shared.fetchCurrentLocationWeather(latitude: lat, longitude: lon)
            
            let weatherData = DomainWeatherModel(
                cityName: weatherResponse.name,
                temperature: weatherResponse.main.temp,
                humidity: weatherResponse.main.humidity,
                icon: weatherResponse.weather.first?.icon ?? "photo",
                id: weatherResponse.weather.first?.id ?? 0,
                description: weatherResponse.weather.first?.description ?? "No Description"
            )
            
            await MainActor.run {
                self.weather = weatherData
            }
            
        } catch {
            print("Error: Fetching Current Weather - \(error.localizedDescription)")
        }
    }

    
    
}
