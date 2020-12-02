//
//  Weather.swift
//  Clima
//
//  Created by Özkan Adar on 27/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    var city: String?
    var delegate: WeatherManagerDelegate?
    let preUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=76b83772c217e4bcf1bdc5f3861640ff&units=metric&q="
    
    mutating func getCity(city: String) {
        let urlString = "\(preUrl)\(city)"
        performURL(url: urlString)
    }
    
    
    func performURL(url: String) {
        
        if let url = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    
                    if let weather =  parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
        
        func parseJSON(weatherData: Data) -> WeatherModel?{
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
                
                //print(weather.temperatureString)
                return weather
                
                
            }
            catch {
                print(error)
                return nil
            }
            
        }
        
       
    }
}

