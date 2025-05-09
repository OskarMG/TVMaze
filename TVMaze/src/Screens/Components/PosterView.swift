//
//  PosterView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct PosterView: View {
    private let strURL: String?
    private let contentMode: ContentMode
    private let width, height, cornerRadius: CGFloat
    
    init(
        url: String?,
        contentMode: ContentMode = .fill,
        cornerRadius: CGFloat = 10,
        width: CGFloat = 100,
        height: CGFloat = 100
    ) {
        self.strURL = url
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        if let strURL {
            AsyncImage(url: URL(string: strURL)) { phase in
                switch phase {
                case .empty:
                    LoadingView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    placeholder
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            placeholder
        }
    }
    
    private var placeholder: some View {
        Image(systemName: "photo")
            .resizable()
            .foregroundColor(.greenGray)
            .frame(width: width, height: height)
            .aspectRatio(contentMode: contentMode)
    }
}
