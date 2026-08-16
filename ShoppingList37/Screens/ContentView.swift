//
//  ContentView.swift
//  ShoppingList37
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var productName = ""
    @State private var isError = false
    private let placeholder = "Введите наименование товара"
    private let subtitleTextField = "Это название уже используется"
    private let titleButton = "Добавить товар"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.Colors.backgroundMain.ignoresSafeArea()
            VStack {
                InsertTextField(
                    insertString: $productName,
                    isError: $isError,
                    placeholder: placeholder,
                    subtitle: subtitleTextField
                )
                .onChange(of: productName) { oldValue, newValue in
                    isError = newValue == "Test"
                }

                Spacer()
                
                BaseButton(title: titleButton, isActive: !productName.isEmpty && !isError) { }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
