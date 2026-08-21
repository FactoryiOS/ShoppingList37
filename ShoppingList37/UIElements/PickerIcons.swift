//
//  Untitled.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 18.08.2026.
//

enum PickerIcon: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case snowflake  = "snow"
    case airplane   = "airplane"
    case alert      = "alert"
    case balloon    = "balloon"
    case bandage    = "bandage"
    case barbell    = "barbell"
    case bed        = "bed"
    case briefcase  = "briefcase"
    case build      = "build"
    case business   = "business"
    case calendar   = "calendar_number"
    case gift       = "gift"
    case color      = "color_palette"
    case cart       = "cart"
    case car        = "car"
    case fastFood   = "fast_food"
    case paw        = "paw"
    case game       = "game_controller"
}
