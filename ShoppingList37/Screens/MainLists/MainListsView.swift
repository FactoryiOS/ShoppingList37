//
//  MainListsView.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 26.08.26.
//
import SwiftUI
import SwiftData

struct MainListsView: View {
    
    @Query private var lists: [ListItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    if lists.isEmpty {
                        PlaceholderView(state: .mainScreen)
                    } else {
                        List {
                            ForEach(lists) { list in
                                ListCellView(item: list)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(
                                        EdgeInsets(
                                            top: 6,
                                            leading: 16,
                                            bottom: 6,
                                            trailing: 16
                                        )
                                    )
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            modelContext.delete(list)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            let newItem = ListItem(
                                                name: "\(list.name) (Копия)",
                                                color: list.color,
                                                icon: list.icon,
                                                items: [],
                                                totalAmount: 0
                                            )
                                            modelContext.insert(newItem)
                                        } label: {
                                            Image(systemName: "plus.square.on.square")
                                        }
                                        .tint(.orange)
                                    }
                            }
                            
                        }
                        .padding(.top, 12)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
                .navigationTitle("Мои списки")
                
                Spacer()
                
                BaseButton(title: "Создать список", isActive: true) {
                    
                }
                .padding(.bottom, 20)
            }
            .background(Color.Colors.backgroundMain)
        }
    }
}

#Preview("Empty") {
    NavigationStack {
        MainListsView()
            .modelContainer(for: ListItem.self, inMemory: true)
    }
}

#Preview("Data") {
    let container = try! ModelContainer(
        for: ListItem.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    for list in ListItem.mocks {
        container.mainContext.insert(list)
    }
    
    return MainListsView()
        .modelContainer(container)
}
