//
//  InnerShadowModifier.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

private struct InnerShadow: ViewModifier {
    let color: Color
    let opacity: Double
    let offsetX, offsetY: CGFloat
    let lineWidth, cornerRadius, blur: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color.opacity(opacity), lineWidth: lineWidth)
                    .blur(radius: blur)
                    .offset(x: offsetX, y: offsetY)
                    .mask(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [color, .clear]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
            )
    }
}

extension View {
    func innerShadow(
        cornerRadius: CGFloat,
        color: Color = .black,
        lineWidth: CGFloat = 4,
        blur: CGFloat = 4,
        offsetX: CGFloat = 2,
        offsetY: CGFloat = 2,
        opacity: Double = 0.4
    ) -> some View {
        self.modifier(
            InnerShadow(
                color: color,
                opacity: opacity,
                offsetX: offsetX,
                offsetY: offsetY,
                lineWidth: lineWidth,
                cornerRadius: cornerRadius,
                blur: blur
            )
        )
    }
}
