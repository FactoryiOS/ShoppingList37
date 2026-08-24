//
//  ListItem.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 24.08.2026.
//

import Foundation

struct ListItem: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let color: ColorOption
    let icon: PickerIcon
    var amount: Int
    let totalAmount: Int
}
