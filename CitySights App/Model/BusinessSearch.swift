//
//  BusinessSearch.swift
//  CitySights App
//
//  Created by Ansh chaturvedi on 10/03/25.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var region = Region()
    var total: Int?
    
}

struct Region: Decodable {
    var center: Coordinate?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?  
}
