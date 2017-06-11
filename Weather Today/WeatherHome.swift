//
//  WeatherHome.swift
//  Weather Today
//
//  Created by Ali Ali on 6/7/17.
//  Copyright © 2017 Ali Ali. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherHome: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CurrentLocationLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    @IBOutlet weak var weatherCategory: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var CW: CurrentWeather!
    var FC: Forecast!
    
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationAuthStatus()
        
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        CW = CurrentWeather()
        CW.downloadWeatherDetails {
            //code to update the UI
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.lattitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.lattitude, Location.sharedInstance.longitude)
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // download forecast data for table view
        let forecastURL = URL(string: FORECAST_URL)!
        
        forecasts.removeAll()
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // Forecast data
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print (obj)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count - 1 // make this dynamic next time
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row + 1]
            cell.configureCell(forecast: forecast)
            return cell
        }
        
        else {
            return WeatherCell()
        }
    }
    
    
    func updateMainUI() {
        DateLabel.text = CW.date
        currentTemp.text = "\(CW.currentTemp)°"
        CurrentLocationLabel.text = CW.cityName
        ImageLabel.image = UIImage(named: CW.weatherType)
        weatherCategory.text = CW.weatherType
    }
}

