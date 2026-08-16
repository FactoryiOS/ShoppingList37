//
//  MainScreenPlaceholderView.swift
//  ShoppingList37
//

import SwiftUI

struct MainScreenPlaceholderView: View {
    
    private let placeholderImage = "Images/img_empty_lists"
    
    var body: some View {
        VStack {
            Image(placeholderImage)
                .resizable()
                .frame(width: 277, height: 277)
            Text("Давайте спланируем покупки!")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 28)
            Text("Создайте свой первый список")
                .font(.body)
                .padding(.top, 4)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainScreenPlaceholderView()
}
