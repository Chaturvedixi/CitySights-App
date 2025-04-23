//
//  TextHelper.swift
//  CitySights App
//
//  Created by Ansh chaturvedi on 11/03/25.
//

import Foundation

struct TextHelper {
    
    static func distanceAwayText(meters: Double) -> String {
        
        if meters < 1000 {
            return "\(Int(round(meters/1000))) Km away"
        } else {
            return "\(Int(round(meters))) m away"
        }
        
    }
}
