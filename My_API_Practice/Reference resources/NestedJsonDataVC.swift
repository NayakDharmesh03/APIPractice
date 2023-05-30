//
//  NestedJsonDataVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 30/05/23.
//

import UIKit

class NestedJsonDataVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func getData(){
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data , error == nil else{
                print("Error Occurd while Accessing Data")
                return
            }
            do{
                
                let userResult = try JSONDecoder().decode(User.self,from: data)
                
                print(userResult.id)
                //This is the stastus code for result
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                print("Status: \(httpResponse.statusCode)")
            }catch let error {
                print("Error Occurd while Decoding JSON into Swift structure Data: \(error)")
            }
            
            
            
        }.resume()
    }

}
