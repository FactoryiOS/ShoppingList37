//
//  ProductView.swift
//  ShoppingList37
//
//  Created by Igor on 24.08.2026.
//

import SwiftUI

struct ProductView: View {
    let create: Bool
    
    @State private var productName = ""
    @State private var productCount = ""
    @State private var unitOfMeasurement: String = "шт"
    
    var body: some View {
        ZStack {
            Color.Colors.backgroundMain.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Отменить")
                            .padding(.leading, 16)
                            .foregroundColor(.Colors.textInactive)
                    }
                    Spacer()
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.Colors.textSecondary)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Готово")
                            .padding(.trailing, 16)
                            .font(.headline)
                            .foregroundColor(filled ? .Colors.accentPressed : .Colors.textInactive)
                    }
                    .disabled(!filled)
                }
                InsertTextField(
                    insertString: $productName,
                    isError: false,
                    placeholder: "Название товара",
                    subtitle: "Такой товар уже есть")
                .padding(.top, 8)
                .padding(.horizontal, 16)
                HStack(spacing: 16) {
                    InsertTextField(
                        insertString: $productCount,
                        isError: false,
                        placeholder: "Количество",
                        subtitle: ""
                    )
                    InsertTextField(
                        insertString: $unitOfMeasurement,
                        isError: false,
                        placeholder: "Ед. изм.",
                        subtitle: ""
                    )
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
                Spacer()
            }
        }
    }
    
    var title: String {
        create ? "Создание товара" : "Редактировать"
    }
    
    var filled: Bool {
        !productName.isEmpty && !productCount.isEmpty && !unitOfMeasurement.isEmpty
    }
}

#Preview("Создание") {
    ProductView(create: true)
}

#Preview("Создание темный") {
    ProductView(create: true)
        .preferredColorScheme(.dark)
}

#Preview("Редактирование") {
    ProductView(create: false)
}

#Preview("Редактирование темный") {
    ProductView(create: false)
        .preferredColorScheme(.dark)
}
