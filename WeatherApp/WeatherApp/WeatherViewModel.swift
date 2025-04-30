//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var cityName: String = ""
    @Published var temp : String = ""

    func loadWeather(name: String) async {
        do{
            let weatherData = try await WeatherService.shared.fetchWeather(cityName: name)
            await MainActor.run {
                self.cityName = weatherData.name
                self.temp = "\(weatherData.main.temp) K"

            }
            
           
            
        }catch{
            print("Error Loading Weather : \(error.localizedDescription)")
        }
    }
    
    
}
