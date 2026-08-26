//
//  MeasurementUnit.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 19.08.2026.
//

import Foundation

enum MeasurementUnit {
    case piece
    case kilogram
    case gram
    case liter
    case milliliter
    
    var short: String {
        switch self {
        case .piece: "шт"
        case .kilogram: "кг"
        case .gram: "г"
        case .liter: "л"
        case .milliliter: "мл"
        }
    }
}
