//
//  AppScheme.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 28.08.2026.
//

import SwiftUI

enum AppScheme: String, CaseIterable {
    case light
    case dark
    case system
    
    var title: String {
        switch self {
        case .light:
            return String(localized: "Светлая")
        case .dark:
            return String(localized: "Тёмная")
        case .system:
            return String(localized: "Системная")
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
