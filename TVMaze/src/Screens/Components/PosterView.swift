//
//  PosterView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 Cencosud. All rights reserved.
//

import SwiftUI

struct PosterView: View {
    private let strURL: String?
    private let width, height, cornerRadius: CGFloat
    
    init(url: String?,
        cornerRadius: CGFloat = 10,
        width: CGFloat = 100,
        height: CGFloat = 100
    ) {
        self.strURL = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        if let strURL {
            AsyncImage(url: URL(string: strURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            Image(systemName: "photo")
        }
    }
}
