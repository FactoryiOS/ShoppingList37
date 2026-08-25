//
//  ShoppingItem.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 19.08.2026.
//

import Foundation

struct ShoppingItem: Identifiable {
    let id: UUID
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
}
