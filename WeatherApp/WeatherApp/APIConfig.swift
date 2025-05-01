//
//  APIConfig.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-04-30.
//
import Foundation
struct APIConfig: Decodable{
    let weatherURL : String
    let weatherAPIKey : String
    let iconURL : String
    
    static let shared: APIConfig = {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else{
            fatalError("Error to load APIConfig.json")
        }
        
        do{
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
            
        }catch{
            fatalError("Failed to Load and decode Json")
        }
        
    }()
}

