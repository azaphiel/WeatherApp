//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    

    var weather = WeatherManager()
    var weatherManager = WeatherManager()
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        cityTextField.delegate = self
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        cityTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if  cityTextField.text! == "" {
            cityTextField.placeholder = "Enter a value"
            return false
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        weather.getCity(city: cityTextField.text!)
        
        cityTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        
        print(weather.temperature)
    }
    
}

