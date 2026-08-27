//
//  MainListsView.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 26.08.26.
//
import SwiftUI

struct MainListsView: View {
    
    @State private var lists: [ListItem]
    
    init(initialLists: [ListItem] = ListItem.mocks) {
        _lists = State(initialValue: initialLists)
    }
    
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
        MainListsView(initialLists: [])
    }
}

#Preview("Data") {
    MainListsView(initialLists: ListItem.mocks)
}
