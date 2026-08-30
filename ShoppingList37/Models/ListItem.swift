//
//  ListItem.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 24.08.2026.
//

import Foundation
import SwiftData

@Model
class ListItem: Identifiable {
    var id = UUID()
    var name: String
    var color: ColorOption
    var icon: PickerIcon
    @Relationship(deleteRule: .cascade)
    var items: [ShoppingItem]
    var totalAmount: Int
    
    var amount: Int {
        items.count
    }
    
    init(
        name: String,
        color: ColorOption,
        icon: PickerIcon,
        items: [ShoppingItem],
        totalAmount: Int
    ) {
        self.name = name
        self.color = color
        self.icon = icon
        self.items = items
        self.totalAmount = totalAmount
    }
    
}

extension ListItem {
    static let mock: ListItem = .init(
        name: "Покупки на неделю",
        color: .blue,
        icon: .airplane,
        items: [
            ShoppingItem(
                title: "Молоко",
                count: 2,
                unit: .piece
            ),
            ShoppingItem(
                title: "Хлеб",
                count: 1,
                unit: .piece
            ),
            ShoppingItem(
                title: "Яблоки",
                count: 5,
                unit: .piece
            )
        ],
        totalAmount: 10
    )

    static let mocks: [ListItem] = [
        .init(
            name: "Новый год",
            color: .blue,
            icon: .calendarNumber,
            items: [
                .mock,
                .purchasedMock
            ],
            totalAmount: 20
        ),
        .init(
            name: "Для кота",
            color: .green,
            icon: .paw,
            items: [
                .mock
            ],
            totalAmount: 4
        ),
        .init(
            name: "Вечеринка",
            color: .yellow,
            icon: .gameController,
            items: [
                .mock,
                .purchasedMock
            ],
            totalAmount: 20
        )
    ]
}
