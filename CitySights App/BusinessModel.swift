//
//  BusinessModel.swift
//  CitySights App
//
//  Created by Anubhav Chaturvedi on 23/03/25.
//

import Foundation
import SwiftUI
import CoreLocation

@Observable
class BusinessModel: NSObject, CLLocationManagerDelegate {
    
    var businesses = [Business]()
    var service = DataService()
    var selectedBusiness: Business?
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getBusinesses(query: String?, options: String?, category: String?) {
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation, query: query, options: options, category: category)
        }
    }
    
    func getUserLcoation() {
        
        // Check if we have permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            
            currentUserLocation = nil
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        self.locationAuthStatus = manager.authorizationStatus
        
        // Detect if user allowed , then request location
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            
            currentUserLocation = nil
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if currentUserLocation == nil {
            
            currentUserLocation = locations.last?.coordinate
            
            // Call business Search
            getBusinesses(query: nil, options: nil, category: nil)
        }
        
        locationManager.stopUpdatingLocation()
    }
}
