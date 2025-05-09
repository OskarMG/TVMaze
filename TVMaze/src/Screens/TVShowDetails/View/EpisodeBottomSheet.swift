//
//  EpisodeBottomSheet.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 9/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct EpisodeBottomSheet: View {
    private let input: Episode
    
    var season: String {
        "Season \(input.season)"
    }
    
    var episode: String {
        let name = input.name
        if let number = input.number {
            return "Episode \(number) : \(name)"
        } else {
            return "Episode - \(name)"
        }
    }
    
    var summary: String {
        (input.summary ?? "No summary").removeHTMLTags()
    }
    
    init(input: Episode) {
        self.input = input
    }
    
    var body: some View {
        VStack(spacing: .padding16) {
            PosterView(
                url: input.image?.original,
                width: .posterSize,
                height: .posterSize
            )
            Text(episode)
                .bold()
            Text(season)
            Text(summary)
                .lineLimit(.limitLines)
                .multilineTextAlignment(.center)
        }
        .padding(.padding16)
    }
}

private extension Int {
    static let limitLines: Int = 5
}

private extension CGFloat {
    static let padding16: CGFloat = 16
    static let posterSize: CGFloat = 150
}
