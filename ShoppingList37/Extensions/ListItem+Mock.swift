//
//  ListItem+Mock.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 24.08.2026.
//

import Foundation

extension ListItem {

    static let mock: ListItem = .init(
        name: "Покупки на неделю",
        color: .blue,
        icon: .airplane,
        amount: 3,
        totalAmount: 10
    )

    static let mocks: [ListItem] = [
        .init(
            name: "Новый год",
            color: .blue,
            icon: .calendarNumber,
            amount: 10,
            totalAmount: 20
        ),
        .init(
            name: "Для кота",
            color: .green,
            icon: .paw,
            amount: 1,
            totalAmount: 4
        ),
        .init(
            name: "Вечеринка",
            color: .yellow,
            icon: .gameController,
            amount: 9,
            totalAmount: 20
        )
    ]
}
