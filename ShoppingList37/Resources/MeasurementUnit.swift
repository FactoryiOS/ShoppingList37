//
//  MeasurementUnit.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 19.08.2026.
//

import Foundation

enum MeasurementUnit: String, CaseIterable, Codable {
    case piece = "шт"
    case kilogram = "кг"
    case gram = "г"
    case liter = "л"
    case milliliter = "мл"
    
    var short: String {
        switch self {
        case .piece: return String(localized: "шт")
        case .kilogram: return String(localized: "кг")
        case .gram: return String(localized: "г")
        case .liter: return String(localized: "л")
        case .milliliter: return String(localized: "мл")
        }
    }
}
