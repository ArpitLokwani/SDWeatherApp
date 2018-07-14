//
//  ViewController.swift
//  SDWeatherApp
//
//  Created by Arpit Lokwani on 7/13/18.
//  Copyright © 2018 SD. All rights reserved.
//

import UIKit

class ViewController:UIViewController,WeatherDelegate {

    let weatherService = WeatherService()
    let weatherViews = WeatherView()
    let backgroundImageView = UIImageView()
    var place:String = ""
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground(type:"thunderbird")
        weatherViews.getWeatherView(vc: self)
        weatherViews.delegate = self
      
        // set location
        let userDefaults = UserDefaults.standard
        place = userDefaults.object(forKey: "place") as! String
        getWeatherDetails(place: place)
        weatherViews.cityLabel.text = place
        setActivityIndicator()
    }

    // get weather Details
    func getWeatherDetails(place:String) -> Void {
        activityIndicator.isHidden = false
        weatherService.getWeatherReport(place:place,completetionHandler: { (success, reponseDict, responseString, error) in
            if success!{
                let weatherArray:NSArray = reponseDict!["weather"] as! NSArray
                print(weatherArray.object(at: 0))
                let weatherDict:NSDictionary = (weatherArray.object(at: 0) as? NSDictionary)!
                
                let mainDict:NSDictionary = reponseDict!["main"] as! NSDictionary
                
                DispatchQueue.main.async {
                    self.weatherViews.cloudStatusLabel.text = weatherDict["description"] as? String
                    if let minTemp = mainDict["temp_min"] as? Double {
                        let celsiusTemp = minTemp - 273.15
                        self.weatherViews.minLabel.text = String(format: "min %.0f°C", celsiusTemp)
                    }
                    
                    if let maxTemp = mainDict["temp_max"] as? Double {
                        let celsiusTemp = maxTemp - 273.15
                        self.weatherViews.maxLabel.text = String(format: " max %.0f°C", celsiusTemp)
                    }

                    if let kelvinTemp = mainDict["temp"] as? Double {
                        let celsiusTemp = kelvinTemp - 273.15
                        self.weatherViews.cityTemperatureLabel.text = String(format: "%.0f°C", celsiusTemp)
                        let celsiusFeelTemp = kelvinTemp - 270.15
                        self.weatherViews.cityFeelTemperatureLabel.text = String(format: "Feels like %.0f°C", celsiusFeelTemp)
                    }
                   
                    if let pressure = mainDict["pressure"] as? Double {
                        self.weatherViews.pressureLabel.text = String(format: "Pressure :%.0f mm", pressure)
                    }
                    
                    if let humidity = mainDict["humidity"] as? Double {
                        self.weatherViews.humidityLabel.text = String(format: "Humidity :%.0f mm", humidity)
                    }
                    
                    self.weatherViews.cityLabel.text = place
                    self.updateBackground(type:(weatherDict["description"] as? String)!)
                    
                }
                
                let windDict:NSDictionary = reponseDict!["wind"] as! NSDictionary
                print(windDict["speed"]!)
                DispatchQueue.main.async {
                    if let windTemp = windDict["speed"] as? Double {
                        self.weatherViews.windLabel.text = String(format: "Wind %.0f kmph", windTemp)
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                }
            }else{
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                }
                
             self.showOKAlertView(title: "Error", message:responseString! as String )
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
            }
            print(error)
        }
    }
    
    func didChangeCityButton() -> Void {
        showAlert(title: Constant.locationTitle, message: Constant.locationMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground(type:String) -> Void {
        backgroundImageView.image = UIImage(named:"clearSKY.jpg")
        backgroundImageView.frame = CGRect(x: -10.0, y: 0.0, width: self.view.frame.size.width + 10, height: self.view.frame.size.height)
        view.addSubview(backgroundImageView)
    }
    
    // update the background as per the climates
    func updateBackground(type:String) -> Void {
        if (type == Constant.clearSky) {
            backgroundImageView.image = UIImage(named:"ClearClouds.jpg")
        }else if (type == Constant.lightRain || type == Constant.moderateRain  || type == Constant.lightIntensityDrizzle) {
            let gif = UIImage.gifImageWithName("lighraining")
            backgroundImageView.image = gif
        }else if (type == Constant.haze) {
            backgroundImageView.image = UIImage(named:"haze.jpg")
        }else if (type == Constant.scatteredClouds) {
            backgroundImageView.image = UIImage(named:"clouds.jpg")
        }else if (type == Constant.fewClouds) {
            backgroundImageView.image = UIImage(named:"ClearClouds.jpg")
        }else if (type == Constant.mist) {
            let gif = UIImage.gifImageWithName(type)
            backgroundImageView.image = gif
        }else if (type == Constant.thunderstorm) {
            let gif = UIImage.gifImageWithName("thunderbird")
            backgroundImageView.image = gif
        }else{
            backgroundImageView.image = UIImage(named:"clearSKY.jpg")
        }
    }

}


//Extensions
extension ViewController{
    
    func showAlert(title:String,message:String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            guard let textFields = alertController.textFields,
                textFields.count > 0 else {
                    // Could not find textfield
                    return
            }
            
            let field = textFields[0]
            // store your data
            UserDefaults.standard.set(field.text, forKey: "place")
            UserDefaults.standard.synchronize()
            
            if(field.text?.count == 0){
                self.showOKAlertView(title: "Error", message: Constant.locationMessage)
            }else{
                self.place = field.text!
                self.getWeatherDetails(place: field.text!)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOKAlertView(title:String,message:String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func moveToWeatherViewController() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // native loader
    func setActivityIndicator() -> Void {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        // Position Activity Indicator in the center of the main view
        activityIndicator.center = view.center
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        activityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
    }
    
}



