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
    @State private var itemToDelete: ShoppingItem?
    
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
                            withAnimation(.easeInOut(duration: 0.3)) {
                                togglePurchased(item)
                            }
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: false
                        ) {
                            Button(role: .destructive) {
                                itemToDelete = item
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
                title: "Добавить товар"
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
        .alert(
            "Удаление товара",
            isPresented: Binding(
                get: {
                    itemToDelete != nil
                },
                set: { isPresented in
                    if !isPresented {
                        itemToDelete = nil
                    }
                }
            )
        ) {
            Button("Удалить", role: .destructive) {
                if let item = itemToDelete {
                    deleteItem(item)
                }
                
                itemToDelete = nil
            }
            
            Button("Отменить", role: .cancel) {
                itemToDelete = nil
            }
        } message: {
            Text("Вы действительно хотите удалить товар?")
        }
    }
    
    private func deleteItem(_ item: ShoppingItem) {
        list.items.removeAll { $0.id == item.id }
        modelContext.delete(item)
        
        do {
            try modelContext.save()
        } catch {
            print("Ошибка удаления товара: \(error)")
        }
    }
    
    private func togglePurchased(_ item: ShoppingItem) {
        item.isPurchased.toggle()
        
        list.items.sort {
            if $0.isPurchased != $1.isPurchased {
                return !$0.isPurchased
            }
            
            return false
        }
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
