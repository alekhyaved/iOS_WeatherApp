//
//  OpenWeather.swift
//  WeatherAssignment
//
//  Created by Leela Alekhya Vedula on 4/2/20.
//  Copyright © 2020 Alekhya. All rights reserved.
//

import Foundation
import SwiftHTTP
import SwiftyJSON



protocol OpenWeatherDelegate {
    
    func displayWeather()
}

class OpenWeather {
    
    var delegate: OpenWeatherDelegate!
    let session = URLSession.shared
    let openWeatherAPIKey = "ecace4f1311408ab704c42bd6535ac38"
   //let openWeatherURL = URL(string: "https://samples.openweathermap.org/data/2.5/weather")
 
 

    public enum HTTPResponse {
               case Failed(error : String)
               case Success(data : Any)
           }
    
    
    var cityName = "San Jose"
    var weatherDescription = "Clear and Sunny"
    var weatherTemp = "21"
    var weatherMinTemp = "20"
    var weatherMaxTemp = "22"
    var weatherIcon = "weatherpicture"
    var countryName = "US"
    //var description = "null"

    
    func loadWeather(city: String) {
        //load weather
        cityName = city.replacingOccurrences(of: " ", with: "%20")
       
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&appid=" + openWeatherAPIKey)
        
       // var urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
         // let urlWithParams = url + "?cityName=\(cityName!)"
        // Add one parameter
      // let urlWithParams = url + "?q=\(cityName!)&appid=\(openWeatherAPIKey!)"
        // Create NSURL Ibject
        //let myUrl = URL(string: urlWithParams);

        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl);
        
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
    
        let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
            // Check if Error took place
            print("in task")
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
             print("Response HTTP Status code: response not coming")
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                do {
                    let json = try? JSON(data: data)
                    let title = json?["weather"][0]["description"].stringValue
                    print("title", title!)
                    
                    
                    
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                  
                                  print(convertedJsonIntoDict)
                  
                        if    let city = convertedJsonIntoDict["name"] as? String
                        {
                            self.cityName = city
                        }
                        let json = try? JSON(data: data)

                        if  let description = json?["weather"][0]["description"].stringValue{
                            self.weatherDescription = description
                         }
                        if  let temperature = json?["main"]["temp"].floatValue{
                            self.weatherTemp = String(format: "%.0f", temperature - 273.15)
                        }
                        if  let temperatureMax = json?["main"]["temp_max"].floatValue{
                       self.weatherMaxTemp = String(format: "%.0f", temperatureMax - 273.15)
                       }
                         if  let temperatureMin = json?["main"]["temp_min"].floatValue{
                         self.weatherMinTemp = String(format: "%.0f", temperatureMin - 273.15)
                        }
                        
                        if  let country = json?["sys"]["country"].stringValue{
                        self.countryName = country
                         }
                        
         
//                        if let description = convertedJsonIntoDict["weather"][0] as? String
//                                              {
//                                                  self.weatherDescription = description
//                                                   print(self.cityName , "userId could not be read")
//                                              }
                       // dispatch_async(dispatch_queue_t, queue, dispatch_block_t block);
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.delegate.displayWeather()
                           
                      })
                    }
                  } catch let error as NSError {
                             print(error.localizedDescription)
                   }
            }

        }
        
        task.resume()
        
    }
init ()
{
    
    }
}



