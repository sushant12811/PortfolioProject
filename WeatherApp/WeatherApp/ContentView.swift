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
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("\(vm.cityName)")
                Text(vm.temp)
                
               
          
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
