//
//  Image+Extension.swift
//  ShoppingList37
//
//  Created by Igor Burkovsky on 16.08.2026.
//

import SwiftUI

extension Image {
    init(system: ImageString) {
        self.init(systemName: system.rawValue)
    }
}
