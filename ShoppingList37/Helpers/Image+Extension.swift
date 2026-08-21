//
//  Image+Extension.swift
//  ShoppingList37
//
//  Created by Igor Burkovsky on 16.08.2026.
//

import SwiftUI

enum ImageString: String {
    case closeButton = "xmark.circle.fill"
    case magnifyingGlass = "magnifyingglass"
}

extension Image {
    init(system: ImageString) {
        self.init(systemName: system.rawValue)
    }
}
