//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-29.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = WeatherViewModel()
    @State private var searchText = ""
    let iconWeatherURL = APIConfig.shared.iconURL
    

    
    var body: some View {
        NavigationStack{
            VStack{
                if let weather = vm.weather{
                    Image(systemName: getWeatherIconSymbol(for: weather.id))
                    Text("\(weather.cityName)")
                    Text("\(weather.temperature.convertToCelsius())°C")
                }
              

            }
            .searchable(text: $searchText)
            .onSubmit(of: .search){
                Task{
                    await vm.loadWeather(name: searchText)
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
