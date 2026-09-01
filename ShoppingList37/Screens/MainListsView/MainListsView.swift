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
    
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationRoute.self) private var router
    
    @AppStorage("appScheme")
    private var appScheme = AppScheme.system.rawValue
    
    private var selectedScheme: AppScheme {
        AppScheme(rawValue: appScheme) ?? .system
    }
    
    @State private var listToDelete: ListItem?
    
    private var themeIcon: String {
        switch selectedScheme {
        case .dark:
            return "circle.lefthalf.filled"
            
        case .light, .system:
            return "circle.righthalf.filled"
        }
    }
    
    private var navigationMenu: some View {
        Menu {
            Menu {
                ForEach(AppScheme.allCases, id: \.self) { scheme in
                    Button {
                        appScheme = scheme.rawValue
                    } label: {
                        HStack {
                            Text(scheme.title)
                            
                            if selectedScheme == scheme {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                Label(
                    "Установить тему",
                    systemImage: themeIcon
                )
            }
        } label: {
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 19.5))
                .frame(width: 44, height: 44)
        }
        .tint(.primary)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Мои списки")
                    .font(.title1)
                    .lineLimit(1)
                
                Spacer()
                
                navigationMenu
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            Group {
                if lists.isEmpty {
                    PlaceholderView(state: .mainScreen)
                        .padding(.top, 88)
                } else {
                    List {
                        ForEach(lists) { list in
                            ListCellView(item: list)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    router.selectedList = list
                                    router.push(.itemsList)
                                }
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
                                .swipeActions(
                                    edge: .trailing,
                                    allowsFullSwipe: false
                                ) {
                                    Button(role: .destructive) {
                                        listToDelete = list
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        duplicate(list)
                                    } label: {
                                        Image(
                                            systemName: "plus.square.on.square"
                                        )
                                    }
                                    .tint(.orange)
                                    
                                    Button {
                                        router.selectedList = list
                                        router.push(.editList)
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }
                                    .tint(Color.gray)
                                }
                        }
                    }
                    .padding(.top, 12)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            
            Spacer()
            
            BaseButton(
                title: "Создать список",
                isActive: true
            ) {
                router.push(.createList)
            }
            .padding(.bottom, 20)
        }
        .background(Color.Colors.backgroundMain)
        .toolbar(.hidden, for: .navigationBar)
        .alert(
            "Удаление списка",
            isPresented: Binding(
                get: {
                    listToDelete != nil
                },
                set: { isPresented in
                    if !isPresented {
                        listToDelete = nil
                    }
                }
            )
        ) {
            Button("Удалить", role: .destructive) {
                if let list = listToDelete {
                    delete(list)
                }
                
                listToDelete = nil
            }
            
            Button("Отменить", role: .cancel) {
                listToDelete = nil
            }
        } message: {
            Text("Вы действительно хотите удалить список?")
        }
    }
    
    private func delete(_ list: ListItem) {
        modelContext.delete(list)
    }
    
    private func duplicate(_ list: ListItem) {
        let copy = ListItem(
            name: "\(list.name) (Копия)",
            color: list.color,
            icon: list.icon,
            items: list.items.map {
                ShoppingItem(
                    title: $0.title,
                    count: $0.count,
                    unit: $0.unit
                )
            }
        )
        
        modelContext.insert(copy)
    }
}

#Preview("Empty") {
    NavigationStack {
        MainListsView()
            .modelContainer(
                for: ListItem.self,
                inMemory: true
            )
    }
    .environment(NavigationRoute())
}
