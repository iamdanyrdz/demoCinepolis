//
//  Shows.swift
//  DemoApp
//
//  Created by Daniel Rodriguez Herrera on 28/06/22.
//

import Foundation

struct FullMovies: Codable {
    let movies: [Movie]
    let routes: [Route]
}

// MARK: - Movie
struct Movie: Codable {
    let originalName, code, genre: String
    let id: Int
    let releaseDate: String
    let synopsis: String
    let name: String
    let cast: [Cast]
    let categories: [String]
    let length: String
    let position: Int
    let media: [Media]
//    let cinemas: [:]
    let distributor, rating: String
}

// MARK: - Cast
struct Cast: Codable {
    let value: [String]
    let label: String
}

// MARK: - Media
struct Media: Codable {
    let code: String?
    let resource: String?
    let type: String?
}

// MARK: - Route
struct Route: Codable {
    let code: String
    let sizes: Sizes
}

// MARK: - Sizes
struct Sizes: Codable {
    let large, xlarge, small, medium: String?
}

struct serviceApproval {
   var approval: Bool?
   var businessMeaning: String?
   var description: String?
   var severityLevel: Int?
   var code: String?
   var hasPayload: Bool?
   var hasDetailResponse: Bool?
   var internalResultReason: String?
   var shouldExit: Bool?
}
