//
//  POSTMathodVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 30/05/23.


//We can tell that they staged because they're under the "Changes to be committed" heading. 

//Now the files are displayed in green and git tells us both of them are new and they are now tracked and staged.

import UIKit
import Alamofire

class POSTMethodVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         addProduct()
        
         loadData() //without alamofire library
        
         loadDataAlf() // using alamofire  library
    }
    
    func addProduct() {
        //Creating URL
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        
        //Data for sending
        let parameters = AddProduct(title: "Dharmesh Nayak")
        
        //creating request
        var request = URLRequest(url: url)
        
        //http method
        request.httpMethod = "POST"
        
        // Model to Data Convert (JSONEncoder() + Encodable)
        request.httpBody = try? JSONEncoder().encode(parameters)
        
        //HTTPHeader
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        
        //Creating data task session
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            do {
                // Data to Model convert - JSONDecoder() + Decodable
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print("ID: \(productResponse.id!) \nTitle: \(productResponse.title)")
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

//NOTE: This is using Alamofire
func loadDataAlf() {
    guard let url = URL(string: "https://reqres.in/api/users/3") else { return }
    
    let bodyParameters = [
        "name": "Darshan",
        "job": "IOS Developer"
    ]
    
    AF.request(url, method: .post, parameters: bodyParameters, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let result = value as? [String: Any] {
                    
                    //this is keys for accesing valus in order
                    let desiredOrder = ["id", "name", "job", "createdAt"]
                    
                    for key in desiredOrder {
                        if let value = result[key] {
                            print("\(key): \(value)")
                        }
                    }
                    //print(result)
                }
                if let httpResponse = response.response {
                    print("Status: \(httpResponse.statusCode)")
                }
            case .failure(let error):
                print("Something went wrong with the request: \(error.localizedDescription)")
            }
        }
}


func loadData() {
    /*
     Note: In this method we can perform three http methos [ POST, PUT, DELETE ]
     
            - if we want to POST or PUT then only change request.httpMethod [ request.httpMethod = "POST" or request.httpMethod = "PUT"]
            - if we want to DELETE data in API then we should delete or comment body parameter and change request.httpMethod = "DELETE"
     */
    
    do {
        guard let url = URL (string: "https://reqres.in/api/users/3") else { return }
        
        //our data in dictionery to postiong nd putting nd deleting
        let bodyParameters = [
            "name": "Dharmesh Nayak",
            "job": "IOS Developer"
        ]
        
        //making url request
        var request = URLRequest(url: url)
        
        //we can change this method like PUT, DELET etc.
        request.httpMethod = "PUT"
        
        //Model to Data Convert (JSONEncoder() + Encodable)
        request.httpBody = try? JSONEncoder().encode(bodyParameters)
        
        //HTTPHeader
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        //Creating Session data task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Something went wrong with the request: \(error.localizedDescription)")
                return
            }
            guard let data = data else { print("No data found.")
                return
            }
            do {
                
                //Result
                guard let result = String(data: data, encoding: .utf8) else { return }
                print(result)
                
                //This is the stastus code for result
                guard let httpResponse = response as? HTTPURLResponse else { return }
                print("Status: \(httpResponse.statusCode)")
            }
            catch let error{
                //Error if data are not found
                print(error.localizedDescription)
            }
        }.resume()
    }
}

