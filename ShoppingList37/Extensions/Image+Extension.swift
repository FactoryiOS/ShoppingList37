//
//  Image+Extension.swift
//  ShoppingList37
//
//  Created by Igor Burkovsky on 16.08.2026.
//

import SwiftUI

<<<<<<< HEAD:ShoppingList37/Helpers/Image+Extension.swift
enum ImageString: String {
    case closeButton = "xmark.circle.fill"
    case magnifyingGlass = "magnifyingglass"
    case upAndDown = "arrow.up.arrow.down"
}

=======
>>>>>>> origin/feature/kostenkoKristina-Add-English-localize:ShoppingList37/Extensions/Image+Extension.swift
extension Image {
    init(system: ImageString) {
        self.init(systemName: system.rawValue)
    }
}
