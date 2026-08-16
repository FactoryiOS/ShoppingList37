//
//  ShoppingListPlaceholderView.swift
//  ShoppingList37
//

import SwiftUI

struct ShoppingListPlaceholderView: View {
    
    let placeholderImage = "Images/img_empty_items"
    
    var body: some View {
        VStack {
            Image(placeholderImage)
                .resizable()
                .frame(width: 343, height: 343)
            Text("Давайте спланируем покупки!")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 28)
            Text("Начните добавлять товары")
                .font(.body)
                .padding(.top, 4)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ShoppingListPlaceholderView()
}
