//
//  ItemsListView.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 25.08.2026.
//

import SwiftUI

struct ItemsListView: View {

    @Environment(NavigationRoute.self) private var router

    @State private var items = ShoppingItem.itemsMock
    @State private var searchText = ""

    private var filteredItems: [ShoppingItem] {
        guard !searchText.isEmpty else {
            return items
        }

        return items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach($items) { $item in
                    ShoppingItemCell(item: $item)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            router.showModal(.editProduct)
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: false
                        ) {
                            Button(role: .destructive) {

                            } label: {
                                Label(
                                    "",
                                    systemImage: "trash"
                                )
                            }

                            Button {
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
                                top: 8,
                                leading: 16,
                                bottom: 8,
                                trailing: 16
                            )
                        )
                }
            }
            .listStyle(.plain)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Поиск"
            )

            BaseButton(
                title: "Добавить товар"
            ) {
                router.showModal(.createProduct)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    NavigationStack {
        ItemsListView()
    }
    .environment(NavigationRoute())
}
