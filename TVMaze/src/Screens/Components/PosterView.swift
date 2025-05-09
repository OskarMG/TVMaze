//
//  PosterView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A view that displays an image loaded asynchronously from a URL,
/// with customizable size, corner radius, and content mode.
/// Shows a placeholder on failure and a loading spinner while loading.
struct PosterView: View {
    
    /// The URL string of the image to display.
    private let strURL: String?
    
    /// The way the image should be scaled inside its frame.
    private let contentMode: ContentMode
    
    /// The width of the image view.
    private let width: CGFloat
    
    /// The height of the image view.
    private let height: CGFloat
    
    /// The corner radius applied to the image.
    private let cornerRadius: CGFloat

    /// Creates a new `PosterView`.
    /// - Parameters:
    ///   - url: A string representing the image URL.
    ///   - contentMode: How the image scales to fit its space. Defaults to `.fill`.
    ///   - cornerRadius: The corner radius to apply. Defaults to `10`.
    ///   - width: The width of the image. Defaults to `100`.
    ///   - height: The height of the image. Defaults to `100`.
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

    /// A default placeholder image shown when no image URL is provided or loading fails.
    private var placeholder: some View {
        Image("defaultPhoto")
            .resizable()
            .foregroundColor(.greenGray)
            .frame(width: width, height: height)
            .aspectRatio(contentMode: contentMode)
    }
}
