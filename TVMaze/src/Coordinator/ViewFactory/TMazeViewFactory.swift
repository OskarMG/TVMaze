//
//  TMazeViewFactory.swift
//  TMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

public final class TMazeViewFactory {
    
    public init() {}
    
    public func makeDashboard(in coordinator: (any MainCoordinatable)?) -> some View {
        ContentView()
    }
}
