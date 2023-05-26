//
//  UserData.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import Foundation

struct ArticleData:Codable{
       let author: String?
       let title: String
       let urlToImage: String?
       let content: String?
}
struct NewsData : Codable{
    let status: String
    let articles: [ArticleData]
}
