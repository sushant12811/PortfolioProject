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
                VStack{
                    if let location = locationManager.location{
                        if let weather = vm.weather{
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
                                
                                Text("\(weather.description)")
                                    .font(.title2.weight(.semibold))
                                
                                
                                Grid() {
                                    GridRow(){
                                        Text(weather.cityName)
                                        Text(weather.cityName)
                                    
                                    }
                                    
                                    GridRow{
                                        Text(weather.cityName)
                                        Text(weather.cityName)
                                        
                                    }
                                }
                            }
                            .foregroundStyle(.white)
                            
                            Spacer()
                            
                        }else{
                            ProgressView()
                                .task{
                                    await vm.loadWeather(lat: location.latitude, lon: location.longitude)
                                }
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backGround1)
                .searchable(text: $searchText, prompt: "Search the city name")
                .onSubmit(of: .search){
                    Task{
                        await vm.loadWeather(name: searchText)
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
