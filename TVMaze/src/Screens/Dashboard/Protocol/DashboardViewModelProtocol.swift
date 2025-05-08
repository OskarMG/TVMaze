//
//  DashboardViewModelProtocol.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 Cencosud. All rights reserved.
//

import Combine

protocol DashboardViewModelProtocol: AnyObject, ObservableObject {
    var shows: ShowsResponse { get }
    /// `Methods`
    func onAppear()
    func nextPage(_ item: TVShow)
    func onTvShowTap(_ tvShow: TVShow)
}
