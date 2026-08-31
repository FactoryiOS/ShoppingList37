//
//  CreateEditListView.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 24.08.26.
//

import SwiftUI
import SwiftData

private enum TextConstants {
    static let createTitle = "Создать список"
    static let editTitle = "Редактировать список"
    static let placeholder = "Введите название списка"
    static let createButton = "Создать"
    static let saveButton = "Сохранить"
}

struct CreateEditListView: View {

    var existingList: ListItem?

    @Environment(\.modelContext) var modelContext
    @Environment(NavigationRoute.self) private var router

    @State private var insertString: String = ""
    @State private var selectedColor: ColorOption?
    @State private var selectedIcon: PickerIcon?

    init(
        existingList: ListItem? = nil,
        initialString: String = "",
        initialColor: ColorOption? = nil,
        initialIcon: PickerIcon? = nil
    ) {
        self.existingList = existingList
        _insertString = State(initialValue: initialString)
        _selectedColor = State(initialValue: initialColor)
        _selectedIcon = State(initialValue: initialIcon)
    }

    private var isEditMode: Bool {
        existingList != nil
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
                    .padding(.horizontal, 16)

                    ColorSelector(
                        selectedColor: $selectedColor,
                        colorSectionText: isEditMode
                            ? ColorSectionText.edit.rawValue
                            : ColorSectionText.create.rawValue
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .padding(.horizontal, 16)

                    IconPickerView(
                        selectedIcon: $selectedIcon,
                        selectionColor: selectedColor?.color
                            ?? ColorOption.blue.color
                    )
                    .padding(.horizontal, 16)
                }
            }

            BaseButton(
                title: isEditMode
                    ? TextConstants.saveButton
                    : TextConstants.createButton,
                isActive: !insertString
                    .trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                    .isEmpty
                    && selectedIcon != nil
                    && selectedColor != nil
            ) {
                guard let selectedColor,
                      let selectedIcon else {
                    return
                }

                if isEditMode {
                    existingList?.name = insertString
                    existingList?.color = selectedColor
                    existingList?.icon = selectedIcon
                } else {
                    let newList = ListItem(
                        name: insertString,
                        color: selectedColor,
                        icon: selectedIcon,
                        items: []
                    )

                    modelContext.insert(newList)
                }

                router.pop()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle(
            isEditMode
                ? TextConstants.editTitle
                : TextConstants.createTitle
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Colors.backgroundMain)
    }
}

#Preview("Create list") {
    NavigationStack {
        CreateEditListView()
    }
    .environment(NavigationRoute())
    .modelContainer(
        for: ListItem.self,
        inMemory: true
    )
}

#Preview("Edit list") {
    NavigationStack {
        CreateEditListView(
            existingList: .mock,
            initialString: "Новый год",
            initialColor: ColorOption.blue,
            initialIcon: PickerIcon.airplane
        )
    }
    .environment(NavigationRoute())
    .modelContainer(
        for: ListItem.self,
        inMemory: true
    )
}
