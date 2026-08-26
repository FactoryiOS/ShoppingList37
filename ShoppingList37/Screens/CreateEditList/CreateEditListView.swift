//
//  CreateEditListView.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 24.08.26.
//

import SwiftUI

private enum TextConstants {
    static let createTitle = "Создать список"
    static let editTitle = "Редактировать список"
    static let placeholder = "Введите название списка"
    static let createButton = "Создать"
    static let saveButton = "Сохранить"
}

struct CreateEditListView: View {
    
    var existingListId: UUID?
    
    @State private var insertString: String = ""
    @State private var selectedColor: ColorOption?
    @State private var selectedIcon: PickerIcon?
    
    init(
        existingListId: UUID? = nil,
        initialString: String = "",
        initialColor: ColorOption? = nil,
        initialIcon: PickerIcon? = nil
    ) {
        self.existingListId = existingListId
        _insertString = State(initialValue: initialString)
        _selectedColor = State(initialValue: initialColor)
        _selectedIcon = State(initialValue: initialIcon)
    }
    
    private var isEditMode: Bool {
        existingListId != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    InsertTextField(
                        insertString: $insertString,
                        isError: false,
                        placeholder: TextConstants.placeholder,
                        subtitle: ""
                    )
                    
                    ColorSelector(
                        selectedColor: $selectedColor,
                        colorSectionText: isEditMode ? ColorSectionText.edit.rawValue : ColorSectionText.create.rawValue
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 16)
                    
                    IconPickerView(selectedIcon: $selectedIcon, selectionColor: selectedColor?.color ?? ColorOption.blue.color)
                        .padding(.horizontal, 16)
                    
                }
            }
            BaseButton(
                title: isEditMode ? TextConstants.saveButton : TextConstants.createButton,
                isActive: !insertString.isEmpty && selectedIcon != nil && selectedColor != nil
            ) {
                
            }
            .padding(.bottom, 20)
        }
        .navigationTitle(isEditMode ? TextConstants.editTitle : TextConstants.createTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Colors.backgroundMain)
        
    }
}

#Preview ("Create list") {
    NavigationStack {
        CreateEditListView()
    }
}
#Preview("Edit list") {
    NavigationStack {
        CreateEditListView(
            existingListId: UUID(),
            initialString: "Новый год",
            initialColor: ColorOption.blue,
            initialIcon: PickerIcon.airplane
        )
    }
}
