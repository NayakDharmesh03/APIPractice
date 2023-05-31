//
//  UserModel.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 30/05/23.
//

import Foundation
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geolocation: Geo
    
    enum CodingKeys: String, CodingKey{
        case street
        case suite
        case city
        case zipcode
        case geolocation = "geo"
    }
}

// MARK: - Geolocation
struct Geo: Codable {
    let lat, lng: String
}


// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
