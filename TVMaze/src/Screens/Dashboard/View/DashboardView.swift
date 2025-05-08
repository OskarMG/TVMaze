//
//  DashboardView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 Cencosud. All rights reserved.
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
        .onAppear(perform: viewModel.onAppear)
    }
    
    private func setupRowFor(_ show: TVShow) -> some View {
        HStack(spacing: .padding16) {
            //PosterView(url: show.image?.medium)
            Text(show.name)
                .onAppear {
                    viewModel.nextPage(show)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .rowHeight, alignment: .leading)
    }
}

private extension CGFloat {
    static let padding16: CGFloat = 16
    static let rowHeight: CGFloat = 120
}
