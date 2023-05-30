//
//  Photos.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import Foundation
struct Photos : Codable {
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
