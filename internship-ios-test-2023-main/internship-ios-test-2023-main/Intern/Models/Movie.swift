//
//  Movie.swift
//  Intern
//
//  Created by Zoltan Vinkler on 23/05/2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var year: Int
    var rating: Double
    var thumbnail: URL
}
