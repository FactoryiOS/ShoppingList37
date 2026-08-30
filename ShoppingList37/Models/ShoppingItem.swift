//
//  ShoppingItem.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 19.08.2026.
//

import Foundation
import SwiftData

@Model
class ShoppingItem: Identifiable {
    var id: UUID
    var title: String
    var count: Int
    var unit: MeasurementUnit
    var isPurchased: Bool

    init(
        id: UUID = UUID(),
        title: String,
        count: Int,
        unit: MeasurementUnit,
        isPurchased: Bool = false
    ) {
        self.id = id
        self.title = title
        self.count = count
        self.unit = unit
        self.isPurchased = isPurchased
    }
}

extension ShoppingItem {
    static let mock = ShoppingItem(
        title: "Молоко",
        count: 2,
        unit: .piece,
        isPurchased: false
    )
    
    static let purchasedMock = ShoppingItem(
        title: "Молоко",
        count: 2,
        unit: .piece,
        isPurchased: true
    )
    
    static let itemsMock = [
        ShoppingItem(title: "Чайник", count: 1, unit: .piece),
        ShoppingItem(title: "Кружка", count: 4, unit: .piece),
        ShoppingItem(title: "Торт", count: 1, unit: .piece, isPurchased: true)
    ]
}
