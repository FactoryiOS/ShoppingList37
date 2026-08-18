//
//  ColorOption.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 18.08.2026.
//

import SwiftUI

enum ColorOption: String, CaseIterable {
    case blue = "Colors/list_blue"
    case green = "Colors/list_green"
    case purple = "Colors/list_purple"
    case red = "Colors/list_red"
    case yellow = "Colors/list_yellow"
    
    var color: Color {
        Color(rawValue)
    }
}
