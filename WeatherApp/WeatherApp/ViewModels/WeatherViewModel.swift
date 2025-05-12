//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var weather: DomainWeatherModel?
    
    //MARK: Load Weather with City name
    func loadWeather(name: String) async {
        do{
            let weatherResponse = try await WeatherService.shared.fetchWeather(cityName: name)
            let weatherData = domainWeatherInstance(weatherResponse: weatherResponse)

            await MainActor.run {
                self.weather = weatherData
            }
        }catch{
            print("Error Loading Weather : \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: Load Weather with COORD
    func loadWeather(lat: Double, lon: Double) async {
        do {
            let weatherResponse = try await WeatherService.shared.fetchCurrentLocationWeather(latitude: lat, longitude: lon)
            let weatherData = domainWeatherInstance(weatherResponse: weatherResponse)
            
            await MainActor.run {
                self.weather = weatherData
            }
            
        } catch {
            print("Error: Fetching Current Weather - \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: Domain weather Data to load it.
    func domainWeatherInstance(weatherResponse: WeatherResponse)-> DomainWeatherModel{
        let weatherData = DomainWeatherModel(
            id: weatherResponse.weather.first?.id ?? 0,
            cityName: weatherResponse.name,
            temperature: weatherResponse.main.temp,
            icon: weatherResponse.weather.first?.icon ?? "photo",
            description: weatherResponse.weather.first?.description ?? "No Description",
            feelsLike: weatherResponse.main.feelsLike,
            temperatureMin: weatherResponse.main.tempMin,
            temperatureMax: weatherResponse.main.tempMax,
            windGust: weatherResponse.wind.gust,
            humidity: weatherResponse.main.humidity
        )
        return weatherData
    }

    
    
}
