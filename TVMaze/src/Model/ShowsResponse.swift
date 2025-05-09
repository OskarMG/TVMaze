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
    let rating: Rating
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
             rating,
             genres,
             status,
             summary,
             schedule
    }
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
    case ended
    case running
    case toBeDetermined
    case none  /// Fallback for `nil` or `unknown`

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .none
            return
        }

        let value = try container.decode(String.self)
        switch value {
        case "Ended": self = .ended
        case "Running": self = .running
        case "To Be Determined": self = .toBeDetermined
        default: self = .none
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .ended:
            try container.encode("Ended")
        case .running:
            try container.encode("Running")
        case .toBeDetermined:
            try container.encode("To Be Determined")
        case .none:
            try container.encodeNil()
        }
    }
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
