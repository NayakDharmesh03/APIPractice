//
//  APIManager.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 31/05/23.
//

//import Foundation
//import Alamofire
//
////using alamofire in this so getting data code is too small ;)
//func getData(){
//   
//    AF.request("https://jsonplaceholder.typicode.com/photos").response { response in
//
//        if let data = response.data{
//            var newsFullList : NewsData?
//            do{
//                newsFullList = try JSONDecoder().decode(Photos.self, from: data)
//            }catch{
//                print("Error Occured while Decoding JSON into swift Structure  \(error)")
//            }
//            self.articlesList = newsFullList!.articles
//            DispatchQueue.main.async {
//                self.myTableView.reloadData()
//            }
//        }
//    }
//}
