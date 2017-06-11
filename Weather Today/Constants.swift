//
//  Constants.swift
//  Weather Today
//
//  Created by Ali Ali on 6/7/17.
//  Copyright © 2017 Ali Ali. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "8a8aa1ffb2e32ed0358c957548264524"

typealias DownloadComplete = () -> ()


//let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)51\(LONGITUDE)1\(APP_ID)\(API_KEY)"

let CURRENT_WEATHER_URL = "HTTP://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longitude!)&appid=8a8aa1ffb2e32ed0358c957548264524"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=8&appid=8a8aa1ffb2e32ed0358c957548264524"


