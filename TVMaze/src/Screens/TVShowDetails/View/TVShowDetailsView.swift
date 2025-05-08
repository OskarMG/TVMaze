//
//  TVShowDetailsView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct TVShowDetailsView<ViewModel>: View where ViewModel: TVShowDetailsViewModelProtocol {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack(spacing: .zero) {
            TVShowBanner(
                summary: viewModel.summary,
                bannerURL: viewModel.bannerUrl
            )
            ScrollView {
                Text(viewModel.summary ?? String.noApply)
                    .padding(.vertical, .padding10)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(.lineLimit)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TVDetailRowView(row: .name, value: viewModel.tvShowName)
                TVDetailRowView(row: .category, value: viewModel.genders)
                TVDetailRowView(row: .rating, value: viewModel.rate)
                TVDetailRowView(row: .schedule, value: viewModel.schedule)
            }
            .padding(.horizontal, .padding16)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.tvShowName)
    }
}

private extension Int {
    static let lineLimit: Int = 4
}

private extension CGFloat {
    static let padding16: CGFloat = 16
    static let padding10: CGFloat = 10
}

private extension String {
    static let noApply = "N/A"
}
