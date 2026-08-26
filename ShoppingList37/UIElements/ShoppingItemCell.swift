//
//  ShoppingItemCell.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 19.08.2026.
//

import SwiftUI

struct ShoppingItemCell: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var item: ShoppingItem
    
    var body: some View {
        HStack(spacing: 12) {
            Group {
                if item.isPurchased {
                    Image(.Icons.checkmarkSquareFull)
                } else {
                    Image(.Icons.checkmarkSquare)
                        .foregroundStyle(
                            colorScheme == .dark
                            ? .white
                            : .primary
                        )
                }
            }
            .frame(width: 44, height: 44)
            
            Text(item.title)
                .font(.body)
                .foregroundStyle(
                    item.isPurchased
                    ? Color(.Colors.textInactive)
                    : Color(.Colors.textPrimary)
                )
            
            Spacer()
            
            Text("\(item.count) \(item.unit.short).")
                .font(.body)
                .foregroundStyle(
                    item.isPurchased
                    ? .secondary
                    : .primary
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview("Не куплено") {
    ShoppingItemCell(item: .constant(.mock))
}

#Preview("Куплено") {
    ShoppingItemCell(item: .constant(.purchasedMock))
}
