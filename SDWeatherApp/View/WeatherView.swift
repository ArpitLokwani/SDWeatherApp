//
//  WeatherView.swift
//  SDWeatherApp
//
//  Created by Arpit Lokwani on 7/13/18.
//  Copyright © 2018 SD. All rights reserved.
//

import UIKit


@objc protocol WeatherDelegate: class{
    @objc optional func didChangeCityButton() -> Void
}

class WeatherView: UIView {

    let minLabel = UILabel()
    let maxLabel = UILabel()
    let cityTemperatureLabel = UILabel()
    let cityFeelTemperatureLabel = UILabel()
    let cloudStatusLabel = UILabel()
    let windLabel = UILabel()
    let timeLabel = UILabel()
    let pressureLabel = UILabel()
    let cityLabel = UILabel()
    let humidityLabel = UILabel()
    let changeCityLabel = UILabel()
    weak var delegate: WeatherDelegate?

    
    var format : DateFormatter!

    func getWeatherView(vc:UIViewController) -> Void {
        let weatherView = UIView()
        weatherView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.size.width, height: vc.view.frame.size.height)
        let weatherScrlView = UIScrollView()
        weatherScrlView.frame = CGRect(x: 20, y: vc.view.frame.size.height-200, width: vc.view.frame.size.width-40, height: vc.view.frame.size.height)
        weatherScrlView.contentSize =         CGSize(width:vc.view.frame.size.width, height: 200)
        weatherScrlView.layer.cornerRadius = 10
        weatherScrlView.layer.borderColor = UIColor.white.cgColor
        weatherScrlView.layer.borderWidth = 1

        // ****************//
        //  Change button  //
        // ****************//
        cityLabel.frame = CGRect(x: 0, y: 10, width: weatherScrlView.frame.size.width, height: 45)
        //cityLabel.text = "Jaipur"
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont(name: "HelveticaNeue-Light", size: 40)!
        cityLabel.textColor = UIColor.white
        weatherScrlView.addSubview(cityLabel)
        
        // ****************//
        //  Pressure Label //
        // ****************//
        pressureLabel.frame = CGRect(x: 20, y: 60, width: 300, height: 40)
        pressureLabel.text = "Pressue : 220mm"
        pressureLabel.textAlignment = .left
        pressureLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        pressureLabel.textColor = UIColor.white
        weatherScrlView.addSubview(pressureLabel)
        
        // ****************//
        //  Humidity Label //
        // ****************//
        humidityLabel.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        humidityLabel.text = "Humadity : 220mm"
        humidityLabel.textAlignment = .left
        humidityLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        humidityLabel.textColor = UIColor.white
        weatherScrlView.addSubview(humidityLabel)
        
        // *******************//
        //  change city Label //
        // *******************//
        changeCityLabel.frame = CGRect(x: weatherScrlView.frame.size.width-100, y:140, width: 100, height: 40)
        changeCityLabel.textAlignment = .center
        changeCityLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)!
        changeCityLabel.textColor = UIColor.white
        weatherScrlView.addSubview(changeCityLabel)
        changeCityLabel.attributedText = NSAttributedString(string: "Change", attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        let changeCityTap = UITapGestureRecognizer(target: self, action: #selector(self.cityChangeButtonPressed))
        changeCityLabel.isUserInteractionEnabled = true
        changeCityLabel.addGestureRecognizer(changeCityTap)
        
        let weatherCircularView = UIView()
        weatherCircularView.frame = CGRect(x: 40, y: 80, width: 300, height: 300)
        weatherCircularView.layer.cornerRadius = 150
        weatherView.addSubview(weatherCircularView)
        weatherCircularView.layer.borderColor = UIColor.lightGray.cgColor
        weatherCircularView.layer.borderWidth = 0.5
        weatherCircularView.alpha = 0.5

        let weatherSeperatorView = UIView()
        weatherSeperatorView.frame = CGRect(x: 10, y: 150, width: 100, height: 1)
        weatherSeperatorView.backgroundColor = UIColor.white
        weatherCircularView.addSubview(weatherSeperatorView)
        
        let jeremyGif = UIImage.gifImageWithName("thunderbird")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 110.0, y: 130.0, width: 70, height: 60)
        

        // ****************//
        //  minimum  Label //
        // ****************//
        minLabel.frame = CGRect(x: 20, y: 110, width: 100, height: 40)
        minLabel.text = "Min 22"
        minLabel.textAlignment = .left
        minLabel.font = UIFont(name: "HelveticaNeue", size: 15.0)!
        minLabel.textColor = UIColor.white
        weatherCircularView.addSubview(minLabel)

        // ****************//
        //  maximum Label  //
        // ****************//
        maxLabel.frame = CGRect(x:weatherCircularView.frame.size.width-90 , y: 110, width: 100, height: 40)
        maxLabel.text = "Max 22"
        maxLabel.textAlignment = .left
        maxLabel.font = UIFont(name: "HelveticaNeue", size: 15.0)!
        maxLabel.textColor = UIColor.white
        weatherCircularView.addSubview(maxLabel)
        
        
        let weatherSeperatorViewRight = UIView()
        weatherSeperatorViewRight.frame = CGRect(x: weatherCircularView.frame.size.width-110, y: 150, width: 100, height: 1)
        weatherSeperatorViewRight.backgroundColor = UIColor.white
        weatherCircularView.addSubview(weatherSeperatorViewRight)

        let weatherCircularViewOuter = UIView()
        weatherCircularViewOuter.frame = CGRect(x: 10, y: 50, width: 360, height: 360)
        weatherCircularViewOuter.layer.cornerRadius = 180
        weatherView.addSubview(weatherCircularViewOuter)
        weatherCircularViewOuter.layer.borderColor = UIColor.white.cgColor
        weatherCircularViewOuter.layer.borderWidth = 30
        weatherCircularViewOuter.alpha = 0.5
        
        
        // ************************//
        //  city temperature Label //
        // ************************//
        cityTemperatureLabel.frame = CGRect(x: 0, y: 90, width: vc.view.frame.size.width, height: 75)
        cityTemperatureLabel.font = UIFont(name: "HelveticaNeue-Light", size: 70.0)!
        cityTemperatureLabel.textAlignment = .center
        cityTemperatureLabel.textColor = UIColor.white
        weatherView.addSubview(cityTemperatureLabel)
        
        
        
        cityFeelTemperatureLabel.frame = CGRect(x: 0, y: 150, width: vc.view.frame.size.width, height: 75)
        cityFeelTemperatureLabel.text = "Feels like 25°C"
        cityFeelTemperatureLabel.textAlignment = .center
        cityFeelTemperatureLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        cityFeelTemperatureLabel.textColor = UIColor.white
        weatherView.addSubview(cityFeelTemperatureLabel)
        
        
       
        cloudStatusLabel.frame = CGRect(x: 0, y: 250, width: vc.view.frame.size.width, height: 25)
     //   cloudStatusLabel.text = "Partly Cloudy"
        cloudStatusLabel.textAlignment = .center
        cloudStatusLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)!
        cloudStatusLabel.textColor = UIColor.white
         weatherView.addSubview(cloudStatusLabel)
        
        
        
        windLabel.frame = CGRect(x: 0, y: 275, width: vc.view.frame.size.width, height: 20)
        windLabel.text = "Wind 20kmph"
        windLabel.textAlignment = .center
        windLabel.font = UIFont(name: "HelveticaNeue-Light", size:15.0)!
        windLabel.textColor = UIColor.white
        weatherView.addSubview(windLabel)
        
        
        
        timeLabel.frame = CGRect(x: 0, y: 310, width: vc.view.frame.size.width, height: 40)
        //timeLabel.text = "09:06 pm"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 40.0)!
        timeLabel.textColor = UIColor.white
        weatherView.addSubview(timeLabel)
        format = DateFormatter()

        format.dateFormat = "hh:mm:ss"
        vc.view.addSubview(weatherView)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateClock), userInfo: nil, repeats: true)

        weatherScrlView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        weatherView.addSubview(weatherScrlView)

    }
    
    @objc func updateClock() {
        let now = NSDate()
        timeLabel.text = format.string(from: now as Date)
        
    }
    @objc func cityChangeButtonPressed() -> Void {
        delegate?.didChangeCityButton!()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
