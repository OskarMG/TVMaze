//
//  TVShowBanner.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct TVShowBanner: View {
    private let summary: String?
    private let bannerURL: String?
    
    init(summary: String?, bannerURL: String?) {
        self.summary = summary
        self.bannerURL = bannerURL
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            PosterView(
                url: bannerURL,
                width: .posterWidth,
                height: .posterHeight
            )
            .shadow(
                color: .black.opacity(.shadowOpacity),
                radius: .radius, x: .zero, y: .shadowY
            )
        }
        .padding(.top, .posterTopPadding)
        .padding(.bottom, .posterBottomPadding)
        .frame(
            maxWidth: .infinity,
            maxHeight: .maxHeight,
            alignment: .center
        )
        .background(.darkBanner.opacity(.colorOpacity))
    }
}

private extension Double {
    static let colorOpacity: Double = 0.5
    static let shadowOpacity: Double = 0.4
}

private extension CGFloat {
    static let shadowY: CGFloat = 5
    static let radius: CGFloat = 20
    static let padding10: CGFloat = 10
    static let maxHeight: CGFloat = 260
    static let posterWidth: CGFloat = 180
    static let posterHeight: CGFloat = 220
    static let posterTopPadding: CGFloat = 5
    static let posterBottomPadding: CGFloat = 10
}
