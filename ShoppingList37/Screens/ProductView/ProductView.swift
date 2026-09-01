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
    let list: ListItem
    let existingItem: ShoppingItem?
    
    @Query private var allItems: [ShoppingItem]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationRoute.self) private var router
    
    @State private var isSaving: Bool = false
    @State private var productName: String
    @State private var productCount: String
    @State private var unitOfMeasurement: MeasurementUnit
    @State private var isDropdownVisible: Bool = false
    @State private var isSelecting: Bool = false
    
    init(
        mode: ProductMode,
        list: ListItem,
        existingItem: ShoppingItem? = nil
    ) {
        self.mode = mode
        self.list = list
        self.existingItem = existingItem
        
        _productName = State(
            initialValue: existingItem?.title ?? ""
        )
        
        _productCount = State(
            initialValue: existingItem.map {
                String($0.count)
            } ?? ""
        )
        
        _unitOfMeasurement = State(
            initialValue: existingItem?.unit ?? .piece
        )
    }
    
    private var allHistoricalItems: [String] {
        let normalizedTitles = allItems.map { item in
            item.title
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .capitalized
        }
        return Array(Set(normalizedTitles)).sorted()
    }
    
    private var filteredSuggestions: [String] {
        let enteredName = productName
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !enteredName.isEmpty else { return [] }
        
        return allHistoricalItems.filter { suggestion in
            suggestion.localizedStandardContains(enteredName) && suggestion.localizedCaseInsensitiveCompare(enteredName) != .orderedSame
        }
    }
    
    private var isDuplicateProduct: Bool {
        guard !isSaving else { return false }
        
        let enteredName = productName
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !enteredName.isEmpty else {
            return false
        }
        
        return list.items.contains { item in
            let existingTitle = item.title
                .trimmingCharacters(in: .whitespacesAndNewlines)
           
            let isSameProduct = existingTitle.localizedCaseInsensitiveCompare(enteredName) == .orderedSame
            
            switch mode {
            case .create:
                return isSameProduct
                
            case .edit:
                return isSameProduct && item.persistentModelID != existingItem?.persistentModelID
            }
        }
    }
    
    
    private var unitMenu: some View {
        Menu {
            ForEach(MeasurementUnit.allCases, id: \.self) { unit in
                Button {
                    unitOfMeasurement = unit
                } label: {
                    if unit == unitOfMeasurement {
                        Image(systemName: "checkmark")
                    }
                    
                    Text(unit.rawValue)
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text("Ед. изм.")
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(unitOfMeasurement.rawValue)
                    .foregroundStyle(Color.Colors.accentPressed)
                
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption)
                    .foregroundStyle(Color.Colors.accentPressed)
            }
            .foregroundStyle(Color.Colors.textSecondary)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.Colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    var body: some View {
        ZStack {
            Color.Colors.backgroundMain
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        router.dismissModal()
                    } label: {
                        Text("Отменить")
                            .padding(.leading, 16)
                            .foregroundColor(
                                .Colors.textInactive
                            )
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(
                            .Colors.textSecondary
                        )
                    
                    Spacer()
                    
                    Button {
                        saveProduct()
                    } label: {
                        Text("Готово")
                            .padding(.trailing, 16)
                            .font(.headline)
                            .foregroundColor(
                                filled
                                ? .Colors.accentPressed
                                : .Colors.textInactive
                            )
                    }
                    .disabled(!filled)
                }
                ZStack(alignment: .top) {
                    VStack(spacing: 20) {
                        InsertTextField(
                            insertString: $productName,
                            isError: isDuplicateProduct,
                            placeholder: "Название товара",
                            subtitle: isDuplicateProduct
                                    ? "Этот товар уже есть в списке, добавьте другой"
                                    : ""
                        )
                        .onChange(of: productName) {
                            isDropdownVisible = !isSelecting
                            isSelecting = false
                        }
                        
                        HStack(spacing: 16) {
                            InsertTextField(
                                insertString: $productCount,
                                isError: false,
                                placeholder: "Количество",
                                subtitle: ""
                            )
                            .onChange(
                                of: productCount
                            ) { oldValue, newValue in
                                onChangeProductCount(
                                    oldValue: oldValue,
                                    newValue: newValue
                                )
                            }
                            
                            unitMenu
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                    
                    if !filteredSuggestions.isEmpty && isDropdownVisible {
                        VStack(alignment: .leading) {
                            ForEach(filteredSuggestions, id: \.self) { suggestion in
                                Text("\(suggestion)")
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        isSelecting = true
                                        productName = suggestion
                                    }
                                Divider()
                            }
                        }
                        .padding()
                        .background(Color.Colors.backgroundSecondary)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 72)
                    }
                }
                
                Spacer()
            }
            .safeAreaPadding(.top)
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
        !productName
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty
        && !productCount.isEmpty
        && !isDuplicateProduct
    }
    
    private func saveProduct() {
        guard filled,
                let count = Int(productCount) else {
            return
        }
        
        isSaving = true
        
        switch mode {
        case .create:
            let item = ShoppingItem(
                title: productName,
                count: count,
                unit: unitOfMeasurement
            )
            
            list.items.append(item)
            
        case .edit:
            existingItem?.title = productName
                .trimmingCharacters(in: .whitespacesAndNewlines)
            existingItem?.count = count
            existingItem?.unit = unitOfMeasurement
        }
        
        do {
            try modelContext.save()
            router.dismissModal()
        } catch {
            assertionFailure("Failed to save product: \(error)")
            isSaving = false
        }
    }
    
    private func onChangeProductCount(
        oldValue: String,
        newValue: String
    ) {
        if newValue.isEmpty {
            return
        }
        
        let isValid = newValue.allSatisfy {
            $0.isNumber
        }
        
        if !isValid {
            productCount = oldValue
        }
    }
}

#Preview("Создание") {
    ProductView(
        mode: .create,
        list: .mock
    )
    .environment(NavigationRoute())
    .modelContainer(
        for: ListItem.self,
        inMemory: true
    )
}

#Preview("Редактирование") {
    ProductView(
        mode: .edit,
        list: .mock,
        existingItem: .mock
    )
    .environment(NavigationRoute())
    .modelContainer(
        for: ListItem.self,
        inMemory: true
    )
}
