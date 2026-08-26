//
//  ListItem.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 24.08.2026.
//

import Foundation

struct ListItem: Identifiable {
    let id = UUID()
    let name: String
    let color: ColorOption
    let icon: PickerIcon
    var items: [ShoppingItem]
    let totalAmount: Int

    var amount: Int {
        items.count
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
