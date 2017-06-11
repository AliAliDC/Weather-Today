//
//  Location.swift
//  Weather Today
//
//  Created by Ali Ali on 6/9/17.
//  Copyright © 2017 Ali Ali. All rights reserved.
//

import CoreLocation

class Location {
    // static var can be accessed anywhere
    static var sharedInstance = Location()
    private init() {}
    
    var lattitude: Double!
    var longitude: Double!
    
    
}
