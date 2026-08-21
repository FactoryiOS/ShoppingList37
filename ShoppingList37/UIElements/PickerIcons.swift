//
//  Untitled.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 18.08.2026.
//

enum PickerIcon: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case snowflake  = "airplane"
    case airplane   = "balloon"
    case alert      = "bandage"
    case balloon    = "barbell"
    case bandage    = "bed"
    case barbell    = "briefcase"
    case bed        = "build"
    case briefcase  = "business"
    case build      = "calendar_number"
    case business   = "car"
    case calendar   = "cart"
    case gift       = "color_palette"
    case color      = "exclamation"
    case cart       = "fast_food"
    case car        = "game_controller"
    case fastFood   = "gift"
    case paw        = "paw"
    case game       = "snowflake"
}
