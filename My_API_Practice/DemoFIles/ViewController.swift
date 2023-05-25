//
//  ViewController.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 23/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // Request parameters
    let todoData: [String: Any] = [
        "userId": 1,
        "title": "Buy groceries",
        "completed": false
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Indicator.isHidden = true

    }

    
    //POST data using post mathod
    @IBAction func postData(_ sender: UIButton) {
        // Convert the request parameters to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: todoData, options: []) else {
            print("Error converting data to JSON")
            return
        }

        // Create the URL request
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Handle the error
                    print("Error: \(error.localizedDescription)")
                    return
                }

                // Process the response
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print("Status code: \(statusCode)")

                    // Process the received data
                    if let data = data {
                        do {
                            // Convert the response data to JSON
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                // Print the JSON data
                                if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                                   let jsonString = String(data: jsonData, encoding: .utf8) {
                                    print("Received JSON data:")
                                    print(jsonString)
                                }
                            }
                        } catch {
                            print("Error while parsing JSON: \(error)")
                        }
                    }
                }
            }
            task.resume()
        }

        
    }
    
    //GET data using get mathod
    @IBAction func getButtonAction(_ sender: UIButton) {
        
        //link of Image
        let strRUl = "https://i0.wp.com/bcciplayerimages.s3.ap-south-1.amazonaws.com/ipl/IPLHeadshot2023/57.png?strip=all"
        
        Indicator.isHidden = false
        
        
        let myURL = URL(string: strRUl)
        
        // prepare HTTP protocol request
        var request = URLRequest(url: myURL!)
        request.httpMethod = "GET"
        
        // Create network session of App
        let urlSession = URLSession.shared
        
        let DataTask : URLSessionDataTask = urlSession.dataTask(with: request, completionHandler: downloadHandler(urlData:response:error:))
                                                              
        DataTask.resume()
        
    }
    
    func downloadHandler(urlData:Data?,response:URLResponse?,error:Error?) -> Void{
        if (urlData != nil && error == nil){
            //data recived
            //convert data in UIImage
            let downlodedImage:UIImage = UIImage(data: urlData!)!
            
            let mainQ = DispatchQueue.main
            mainQ.async (execute: {
                self.imageView.image = downlodedImage
                self.Indicator.isHidden = true
            })
        }else{
            print("Error: \(String(describing: error?.localizedDescription))")
            return
        }
    }
}

