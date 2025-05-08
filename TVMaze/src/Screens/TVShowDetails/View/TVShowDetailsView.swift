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
        Text("REPLACE ME")
    }
}

#Preview {
    TVShowDetailsView(viewModel: TVShowDetailsViewModel())
}
