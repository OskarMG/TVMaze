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
        ZStack {
            switch viewModel.stateView {
            case .error:
                EmptyStateView(
                    icon: String.unavailable,
                    message: String.somethingWentWrong,
                    action: .init(label: String.tryAgain, action: viewModel.onTryAgain)
                )
            case .loading:
                LoadingView(title: String.loading)
            case .content:
                ScrollView {
                    LazyVStack(spacing: .padding16) {
                        TMSearchBar(input: $viewModel.searchInput)
                        if viewModel.isFiltering {
                            if viewModel.showEmptyStateVisibleForFilter {
                                EmptyStateView(icon: String.search, message: String.nomatch)
                            } else {
                                ForEach(viewModel.filteredShows, content: setupRowFor(_:))
                            }
                        } else {
                            ForEach(viewModel.shows, content: setupRowFor(_:))
                        }
                        
                    }
                    .padding(.horizontal, .padding16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle(String.title)
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
    static let tryAgain = "Try again"
    static let search = "magnifyingglass"
    static let loading = "Loading content..."
    static let unavailable = "exclamationmark.icloud"
    static let somethingWentWrong = "Ups! Something went wrong..."
    static let nomatch = "No TV shows found matching your search."
}
