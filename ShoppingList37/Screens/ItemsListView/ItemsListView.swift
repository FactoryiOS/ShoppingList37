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
    
    @Environment(\.modelContext) private var modelContext
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
    
    private var navigationMenu: some View {
        Menu {
            Button {
                sortItems()
            } label: {
                Label {
                    Text("Сортировка по Алфавиту")
                } icon: {
                    Image(system: .upAndDown)
                }
            }
            
            ShareLink(item: shareText) {
                Label {
                    Text("Поделиться")
                } icon: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            Button {
                uncheckAllItems()
            } label: {
                Label {
                    Text("Снять отметки со всех товаров")
                } icon: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            
            Button(role: .destructive) {
                showAlertDeleteAll = true
            } label: {
                Label {
                    Text("Удалить купленные товары")
                } icon: {
                    Image(systemName: "trash")
                }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
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
                                Image(systemName: "trash")
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    navigationMenu
                }
            }

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
        .alert("Удаление купленных товаров", isPresented: $showAlertDeleteAll) {
            Button("Отменить", role: .cancel) {
                showAlertDeleteAll = false
            }
            Button("Удалить", role: .destructive) {
                showAlertDeleteAll = false
                deleteAllItems()
            }
        } message: {
            Text("Вы действительно хотите удалить все купленные товары?")
        }
    }
    
    private func deleteItem(_ item: ShoppingItem) {
        list.items.removeAll { $0.id == item.id }
        
        modelContext.delete(item)
        saveContext()
    }

    private func sortItems() {
    }
    
    var shareText: String {
        list.items.map { item in
            let status = item.isPurchased ? "[x]" : "[ ]"
            return "\(status) \(item.title) — \(item.count) \(item.unit.rawValue)"
        }.joined(separator: "\n")
    }

    private func uncheckAllItems() {
        for item in list.items {
            item.isPurchased = false
        }
        saveContext()
    }
    
    private func deleteAllItems() {
        list.items.removeAll()
        saveContext()
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch { }
        modelContext.delete(item)
        
        do {
            try modelContext.save()
        } catch {
            assertionFailure("Failed to delete item: \(error)")
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
