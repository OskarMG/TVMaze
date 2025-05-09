//
//  SeasonCarousel.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A horizontally scrollable carousel view that displays a list of episodes as posters for a specific season.
/// Each poster shows the episode image and overlays the episode name at the bottom.
struct SeasonCarousel: View {

    /// The title or name of the season.
    private let name: String

    /// The list of episodes to be displayed in the carousel.
    private let episodes: EpisodesResponse

    /// Initializes a new `SeasonCarousel` with a season name and list of episodes.
    /// - Parameters:
    ///   - name: The name of the season to display above the carousel.
    ///   - episodes: The collection of episodes shown in the carousel.
    init(name: String, episodes: EpisodesResponse) {
        self.name = name
        self.episodes = episodes
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .padding10) {
            // Season title
            Text(name)
                .bold()
                .foregroundColor(.primary)
            
            // Horizontal scrollable carousel of episodes
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: .padding16) {
                    ForEach(Array(episodes.enumerated()), id: \.offset) { _, episode in
                        setupRowFor(episode)
                    }
                }
            }
        }
        .padding(.vertical, .padding10)
    }

    /// Builds a poster view for an individual episode.
    /// - Parameter episode: The episode to display.
    /// - Returns: A view representing the episode.
    private func setupRowFor(_ episode: Episode) -> some View {
        PosterView(
            url: episode.image?.medium,
            cornerRadius: .padding16,
            width: .posterSize,
            height: .posterSize
        )
        .innerShadow(cornerRadius: .padding16)
        .overlay(setuLabel(name: episode.name), alignment: .bottomLeading)
    }

    /// Creates a label view with the episode name, styled as a bottom overlay.
    /// - Parameter name: The name of the episode.
    /// - Returns: A view with the episode name overlaid on the poster.
    private func setuLabel(name: String) -> some View {
        VStack(spacing: .zero) {
            Text(name)
                .bold()
                .foregroundColor(.white)
        }
        .padding(.horizontal, .padding16)
        .frame(width: .posterSize, height: .labelHeight)
        .background(.black.opacity(.labelOpacity))
        .cornerRadius(.padding16, corners: [.bottomLeft, .bottomRight])
    }
}

// MARK: - Constants

private extension Double {
    static let labelOpacity: Double = 0.6
}

private extension CGFloat {
    static let padding10: CGFloat = 10
    static let padding16: CGFloat = 16
    static let labelHeight: CGFloat = 50
    static let posterSize: CGFloat = 150
}
