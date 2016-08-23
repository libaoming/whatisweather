//
//  ViewController.swift
//  whatsWeather
//
//  Created by 李宝明 on 16/8/23.
//  Copyright © 2016年 李宝明. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var textFeild: UITextField!
    
    @IBAction func forecast(_ sender: AnyObject) {
        
        if let text = textFeild.text {
            
            if  let url = URL(string: "http://www.weather-forecast.com/locations/\(text.replacingOccurrences(of: " ", with: "-"))/forecasts/latest") {
                
                let request = URLRequest(url: url)
                
                var message = ""
                
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response , error in
                    
                    if error != nil {
                        print(error)
                    }else {
                        
                        if let unwrappedData = data {
                            
                            let dataStr = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                            var separatedBy = "</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                            if let strArray = dataStr?.components(separatedBy: separatedBy) {
                                
                                if strArray.count > 1 {
                                    
                                    separatedBy = "</span>"
                                    
                                    let newContentArray = strArray[1].components(separatedBy: separatedBy)
                                    
                                    if newContentArray.count > 1 {
                                        print("+++++++++++++++++++++++++")
                                        print("+++++++++++++++++++++++++")
                                        print("+++++++++++++++++++++++++")
                                        
                                        message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                        
                                        print(message)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                    
                    if message == "" {
                        message = "don't get forecast, please try again"
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.result.text = message
                    })
                    
                }
                
                task.resume()
                
                
            }

        }
        
        
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFeild.resignFirstResponder()
        forecast(btn)
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
}

