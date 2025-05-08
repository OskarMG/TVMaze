//
//  TMIRow.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

private extension Image {
    static let tvIcon = Image(systemName: "tv")
    static let ratingIcon = Image(systemName: "star")
    static let scheduleIcon = Image(systemName: "calendar")
    static let libraryIcon = Image(systemName: "books.vertical")
}

enum TMIRow {
    case name
    case category
    case rating
    case schedule
    
    var icon: Image {
        switch self {
        case .name: return Image.tvIcon
        case .category: return Image.libraryIcon
        case .rating: return Image.ratingIcon
        case .schedule: return Image.scheduleIcon
        }
    }
    
    var label: String {
        switch self {
        case .name: return "Name"
        case .category: return "Gender"
        case .rating: return "Vote average"
        case .schedule: return "Schedule"
        }
    }
}
