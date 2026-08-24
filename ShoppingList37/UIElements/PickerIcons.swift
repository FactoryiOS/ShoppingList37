//
//  Untitled.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 18.08.2026.
//

import SwiftUI

enum PickerIcon: CaseIterable, Identifiable {

    var id: Self { self }

    case airplane
    case balloon
    case bandage
    case barbell
    case bed
    case briefcase
    case build
    case business
    case calendarNumber
    case car
    case cart
    case colorPalette
    case exclamation
    case fastFood
    case gameController
    case gift
    case paw
    case snowflake

    var image: Image {
        switch self {
        case .airplane:
            Image(.Icons.airplane)
        case .balloon:
            Image(.Icons.balloon)
        case .bandage:
            Image(.Icons.bandage)
        case .barbell:
            Image(.Icons.barbell)
        case .bed:
            Image(.Icons.bed)
        case .briefcase:
            Image(.Icons.briefcase)
        case .build:
            Image(.Icons.build)
        case .business:
            Image(.Icons.business)
        case .calendarNumber:
            Image(.Icons.calendarNumber)
        case .car:
            Image(.Icons.car)
        case .cart:
            Image(.Icons.cart)
        case .colorPalette:
            Image(.Icons.colorPalette)
        case .exclamation:
            Image(.Icons.exclamation)
        case .fastFood:
            Image(.Icons.fastFood)
        case .gameController:
            Image(.Icons.gameController)
        case .gift:
            Image(.Icons.gift)
        case .paw:
            Image(.Icons.paw)
        case .snowflake:
            Image(.Icons.snowflake)
        }
    }
}
