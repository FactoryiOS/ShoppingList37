//
//  ProductView.swift
//  ShoppingList37
//
//  Created by Igor on 24.08.2026.
//

import SwiftUI
import SwiftData

enum ProductMode {
    case create
    case edit
}

struct ProductView: View {
    let mode: ProductMode
    var list: ListItem
    var existingItem: ShoppingItem?
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var productName = ""
    @State private var productCount = ""
    @State private var unitOfMeasurement: MeasurementUnit? = MeasurementUnit.piece
    @State private var unitOfMeasurementName: String = "шт"
    
    var body: some View {
        ZStack {
            Color.Colors.backgroundMain.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        dismiss()
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
                        if mode == .create {
                            let newItem = ShoppingItem(
                                title: productName,
                                count: Int(productCount) ?? 1,
                                unit: unitOfMeasurement ?? .piece
                            )
                            list.items.append(newItem)
                        } else {
                            existingItem?.title = productName
                            existingItem?.count = Int(productCount) ?? 1
                            existingItem?.unit = unitOfMeasurement ?? .piece
                        }
                        dismiss()
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
                    .onChange(of: productCount) { oldValue, newValue in
                        onChangeProductCount(oldValue: oldValue, newValue: newValue)
                    }
                    
                    InsertTextField(
                        insertString: $unitOfMeasurementName,
                        isError: false,
                        placeholder: "Ед. изм.",
                        subtitle: ""
                    )
                    .onChange(of: unitOfMeasurementName) { oldValue, newValue in
                        onChangeUnitOfMeasurementName(oldValue: oldValue, newValue: newValue)
                    }
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
                Spacer()
            }
        }
    }
    
    private var title: String {
        switch mode {
        case .create:
            return "Создание товара"
        case .edit:
            return "Редактировать"
        }
    }
    
    private var filled: Bool {
        !productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !productCount.isEmpty && unitOfMeasurement != nil
    }
    
    private func onChangeProductCount(oldValue: String, newValue: String) {
        if newValue.isEmpty { return }
        
        let isValid = newValue.allSatisfy { $0.isNumber }
        if !isValid {
            productCount = oldValue
        }
    }
    
    private func onChangeUnitOfMeasurementName(oldValue: String, newValue: String) {
        if newValue.isEmpty {
            unitOfMeasurement = nil
            return
        }
        
        let units = MeasurementUnit.allCases.filter { measurement in
            measurement.rawValue.lowercased().hasPrefix(newValue.lowercased())
        }
        
        if units.isEmpty {
            unitOfMeasurement = nil
            unitOfMeasurementName = oldValue
        }
        
        // Все оставшиеся символы дописываем
        if units.count == 1 {
            unitOfMeasurement = units.first
            unitOfMeasurementName = units.first?.rawValue ?? ""
        } else {
            unitOfMeasurement = nil
        }
    }
}

#Preview("Создание") {
    ProductView(mode: .create, list: .mock)
}

#Preview("Редактирование") {
    ProductView(mode: .edit, list: .mock, existingItem: .mock)
}
