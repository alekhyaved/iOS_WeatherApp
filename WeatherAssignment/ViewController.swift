//
//  ViewController.swift
//  WeatherAssignment
//
//  Created by Leela Alekhya Vedula on 4/2/20.
//  Copyright © 2020 Alekhya. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON


class ViewController: UIViewController, OpenWeatherDelegate{

    var openWeather = OpenWeather()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

     let openWeatherAPI = "ecace4f1311408ab704c42bd6535ac38"
    

    
    @IBOutlet weak var cityButton: UIBarButtonItem!
    
    @IBAction func cityButtonTapped(_ sender: Any) {
    //display alert
         displayCityAlert()
    }
    func displayCityAlert(){
            let alert = UIAlertController(title: "City", message: "Enter City name", preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in
            if let textField: UITextField = alert.textFields?.first as? UITextField {
                self.cityNameLabel.text = textField.text?.capitalized
                //let convert = textField
                print("convert", textField.text!)
                self.openWeather.loadWeather(city: textField.text!)
            }
        })
        alert.addAction(ok)
    
        alert.addTextField { (textField) in
            textField.placeholder = "City name"
        }
            self.present(alert, animated: true, completion: nil)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        descriptionLabel.text = "Mostly Cloudy"
        tempLabel.text="14"
        cityNameLabel.text = "San Jose"
        weatherImage.image = UIImage(named: "weatherpicture")
       // weatherImage.layer.masksToBounds = true
        weatherImage.layer.cornerRadius = weatherImage.bounds.width / 3
       // openWeather.loadWeather()
        openWeather.delegate = self
        
    }
     
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    func displayWeather()
    {
        print("openWeather", openWeather.weatherDescription)
        descriptionLabel.text = openWeather.weatherDescription
        tempLabel.text = openWeather.weatherTemp
        print("openWeather", openWeather.weatherDescription)
         dateLabel.text = openWeather.countryName
         minTempLabel.text = openWeather.weatherMinTemp
         maxTempLabel.text = openWeather.weatherMaxTemp
      
    }
}

