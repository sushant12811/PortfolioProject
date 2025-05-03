//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-05-01.
//
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate,ObservableObject{
    
    @Published var location: CLLocationCoordinate2D?
    
    var locationManager = CLLocationManager()
    
    func locationAuthorization(){
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() // user hasnot determined about giving access to the app
        case .restricted:
            print("Location Restricted")                  //The app is not authorized to use location services.
        case .denied:
            print("Location Denied")     //The user denied the use of location services or may be disabled globally in Settings
        case .authorizedAlways:
            print("Location Authorization Always")
        case .authorizedWhenInUse:
            print("Location authorized when in use")
            location = locationManager.location?.coordinate
        @unknown default:
            fatalError("Location Service Disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        locationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    
}
