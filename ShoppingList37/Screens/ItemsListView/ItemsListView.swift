//
//  ItemsListView.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 25.08.2026.
//

import SwiftUI
import SwiftData

struct ItemsListView: View {

    @State private var searchText = ""

    @Environment(\.modelContext) var modelContext
    @Environment(NavigationRoute.self) private var router

    let list: ListItem

    private var filteredItems: [ShoppingItem] {
        guard !searchText.isEmpty else {
            return list.items
        }

        return list.items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(filteredItems) { item in
                    ShoppingItemCell(item: item)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            item.isPurchased.toggle()
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: false
                        ) {
                            Button(role: .destructive) {
                                modelContext.delete(item)
                            } label: {
                                Label(
                                    "",
                                    systemImage: "trash"
                                )
                            }

                            Button {
                                router.selectedList = list
                                router.selectedItem = item
                                router.showModal(.editProduct)
                            } label: {
                                Label(
                                    "",
                                    systemImage: "square.and.pencil"
                                )
                            }
                            .tint(.Colors.swipeLightGrey)
                        }
                        .listRowInsets(
                            EdgeInsets(
                                top: 0,
                                leading: 16,
                                bottom: 0,
                                trailing: 16
                            )
                        )
                }
            }
            .listStyle(.plain)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(
                    displayMode: .always
                ),
                prompt: "Поиск"
            )

            BaseButton(
                title: String(localized: "Добавить товар")
            ) {
                router.selectedList = list
                router.selectedItem = nil
                router.showModal(.createProduct)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .navigationTitle(list.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

#Preview {
    NavigationStack {
        ItemsListView(list: .mock)
            .modelContainer(
                for: ListItem.self,
                inMemory: true
            )
    }
    .environment(NavigationRoute())
}
