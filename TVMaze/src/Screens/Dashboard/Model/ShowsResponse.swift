//
//  ShowsResponse.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public typealias ShowsResponse = [TVShow]

public struct TVShow: Codable, Identifiable {
    public let id: Int
    let url: String
    let name: String
    let image: Poster?
    let status: Status
    let genres: [String]
    let summary: String?
    let schedule: Schedule
    let type: TVShowCategory

    enum CodingKeys: String, CodingKey {
        case id,
             url,
             name,
             type,
             image,
             genres,
             status,
             summary,
             schedule
    }
}

public struct Poster: Codable {
    let medium, original: String
}

public struct Episode: Codable {
    let href: String
    let name: String
}

public struct Schedule: Codable {
    let time: String
    let days: [Day]
}

enum Day: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case saturday = "Saturday"
    case friday = "Friday"
    case sunday = "Sunday"
}

enum Status: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
}

enum TVShowCategory: String, Codable {
    case news = "News"
    case sports = "Sports"
    case reality = "Reality"
    case variety = "Variety"
    case scripted = "Scripted"
    case talkShow = "Talk Show"
    case gameShow = "Game Show"
    case animation = "Animation"
    case awardShow = "Award Show"
    case panelShow = "Panel Show"
    case documentary = "Documentary"
}
