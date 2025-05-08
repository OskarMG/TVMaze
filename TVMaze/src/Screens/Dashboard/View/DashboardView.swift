//
//  DashboardView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct DashboardView<ViewModel>: View where ViewModel: DashboardViewModelProtocol {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .zero) {
                ForEach(viewModel.shows, content: setupRowFor(_:))
            }
            .padding(.horizontal, .padding16)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .navigationTitle(String.title)
        .onAppear(perform: viewModel.onAppear)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func setupRowFor(_ show: TVShow) -> some View {
        Button(action: { viewModel.onTvShowTap(show) }) {
            HStack(spacing: .padding16) {
                PosterView(
                    url: show.image?.medium,
                    width: .posterWidth,
                    height: .rowHeight
                )
                VStack(spacing: .zero) {
                    Text(show.name)
                        .bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: .padding4) {
                        Text(String.status)
                            .foregroundColor(.primary)
                        Text(show.status.rawValue)
                            .foregroundColor(.secondary)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .rowHeight,
                alignment: .leading
            )
            .padding(.vertical, .rowVPadding)
        }
        .onAppear { viewModel.nextPage(show) }
    }
}

private extension CGFloat {
    static let padding4: CGFloat = 4
    static let padding16: CGFloat = 16
    static let rowHeight: CGFloat = 120
    static let rowVPadding: CGFloat = 10
    static let posterWidth: CGFloat = 100
}

private extension String {
    static let title = "TV Shows"
    static let status = "Status:"
}
