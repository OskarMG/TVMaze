//
//  MainCoordinatable.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public protocol MainCoordinatable: AnyObject, Coordinatable {
    func didTapOnTvShow(_ tvShow: TVShow)
}
