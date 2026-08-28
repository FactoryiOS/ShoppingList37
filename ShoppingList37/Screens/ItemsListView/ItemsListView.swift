//
//  ItemsListView.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 25.08.2026.
//

import SwiftUI
import SwiftData

struct ItemsListView: View {
    @State private var selectedItem: ShoppingItem?
    @State private var searchText = ""
    @State private var isShowingCreateSheet = false
    @Environment(\.modelContext) var modelContext
    var list: ListItem

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
                        .onTapGesture {
                            item.isPurchased.toggle()
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                modelContext.delete(item)
                            } label: {
                                Label("", systemImage: "trash")
                            }
                            
                            Button {
                                selectedItem = item
                            } label: {
                                Label("", systemImage: "square.and.pencil")
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
               isShowingCreateSheet = true
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .sheet(isPresented: $isShowingCreateSheet) {
            ProductView(mode: .create, list: list)
        }
        .sheet(item: $selectedItem){ unwrappedItem in
            ProductView(mode: .edit, list: list, existingItem: unwrappedItem)
        }
    }
}

#Preview {
    NavigationStack {
        ItemsListView(list: .mock)
            .modelContainer(for: ListItem.self, inMemory: true)
    }
}
