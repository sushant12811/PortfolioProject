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
    @StateObject private var locationManager = LocationManager()
    
    
    var body: some View {
        NavigationStack{
               
            ZStack {
                VStack{
                    if let location = locationManager.location{
                        if let weather = vm.weather{
                            VStack {
                                VStack{
                                    Image(systemName: getWeatherIconSymbol(for: weather.id))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                        .shadow(color:Color.gray,radius: 5)
                                    Text("\(weather.temperature.convertToCelsius())°C")
                                        .font(.largeTitle.bold())
                                    
                                    Text("\(weather.cityName)")
                                        .font(.title.bold())
                                    
                                    Text("\(weather.description.capitalized)")
                                        .font(.title2.weight(.semibold))
                                    
                                    
                                }
                                .padding()
                                
                                HStack{
                                    VStack{
                                        Text("Feels Like")
                                        Text("\(weather.feelsLike.convertToCelsius())°C")
                                    }
                                    .padding(.vertical,20)
                                    .padding(.horizontal, 50)                      .background(Color.white.opacity(0.2))
                                    .clipShape(.rect(cornerRadius: 15))
                                    .shadow(color:.white.opacity(0.2), radius: 5)
                                    Spacer()
                                    VStack{
                                        HStack(spacing:12){
                                            Text("Low")
                                            Text("High")
                                        }
                                        HStack(spacing:12){
                                            Text("\(weather.temperatureMin.convertToCelsius())°C")
                                            Text("\(weather.temperatureMax.convertToCelsius())°C")
                                        }
                                    }
                                    .padding(.vertical,20)
                                    .padding(.horizontal, 50)
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(.rect(cornerRadius: 15))
                                    
                                }
                                .font(.headline)
                                .padding(.horizontal,20)
                                Spacer()
                                
                            }
                            .background(getBackgroundSks(for: weather.id))
                            
                            
                        }else{
                            ProgressView()
                                .task{
                                    await vm.loadWeather(lat: location.latitude, lon: location.longitude)
                                    print("\(location.latitude) \(location.longitude)")
                                }
                            
                        }
                    }
                    
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .searchable(text: $searchText, prompt: "Search the city name")
                .onSubmit(of: .search){
                    Task{
                        await vm.loadWeather(name: searchText)
                    }
                    
                    
                    
                }
            }
            
            
            
        }
        .onAppear{
            locationManager.locationAuthorization()
            
            
            
        }
        
        
        
        
    }
    
    private func linearGradient() ->  LinearGradient{
        return LinearGradient(gradient: Gradient(colors: [.backGround2.opacity(0.7), .backGround1.opacity(0.7)]), startPoint: .bottomLeading, endPoint: .topTrailing)
        
    }
}

#Preview {
    ContentView()
}
