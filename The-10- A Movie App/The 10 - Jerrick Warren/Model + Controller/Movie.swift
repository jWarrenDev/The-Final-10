//
//  Movie.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/13/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import Foundation


struct Movie: Codable {
    let results : [Results]
    
    enum CodingKeys: String, CodingKey {
        case results         = "results"
    }
}

struct Results: Codable {
    
    let id : Int
    let title: String
    let vote_average: Double
    let overview: String
    let release_date: String
    let poster_path: String
    
    enum CodingKeys: String, CodingKey {
        case id              = "id"
        case title           = "title"
        case vote_average    = "vote_average"
        case poster_path     = "poster_path"
        case overview        = "overview"
        case release_date    = "release_date"
        
    }
}




