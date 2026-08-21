//
//  ColorOption.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 18.08.2026.
//

import SwiftUI

enum ColorOption: String, CaseIterable {
    case blue
    case green
    case purple
    case red
    case yellow 
    
    var color: Color {
        switch self {
        case .blue:
            Color.Colors.listBlue
        case .green:
            Color.Colors.listGreen
        case .purple:
            Color.Colors.listPurple
        case .red:
            Color.Colors.listRed
        case .yellow:
            Color.Colors.listYellow
        }
    }
}
