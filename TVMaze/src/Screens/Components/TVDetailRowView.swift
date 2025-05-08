//
//  TVDetailRowView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct TVDetailRowView: View {
    let row: TMIRow
    let value: String
    
    init(row: TMIRow, value: String) {
        self.row = row
        self.value = value
    }
    
    init(row: TMIRow, value: [String]) {
        self.row = row
        self.value = value.joined(separator: ", ")
    }
    
    var body: some View {
        HStack(spacing: .padding8) {
            row.icon
                .foregroundColor(.greenGray)
                .frame(width: .iconSize, height: .iconSize)
                .scaledToFill()
            Text(row.label)
                .bold()
                .foregroundColor(.greenGray)
            Spacer()
            Text(value)
        }
        .padding(.top, .padding8)
        .padding(.bottom, .padding16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottom, content: setupDivider)
    }
    
    private func setupDivider() -> some View {
        Rectangle()
            .foregroundColor(.secondary)
            .frame(height: .dividerHeight)
    }
}

private extension CGFloat {
    static let padding8: CGFloat = 8
    static let iconSize: CGFloat = 24
    static let padding16: CGFloat = 16
    static let dividerHeight: CGFloat = 1
}
