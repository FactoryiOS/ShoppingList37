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
    @State private var isShowingCreateSheet = false
    @AppStorage("appScheme")
    
    private var appScheme = AppScheme.system.rawValue
    
    private var selectedScheme: AppScheme {
        AppScheme(rawValue: appScheme) ?? .system
    }
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
                Label("Установить тему", systemImage: themeIcon)
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
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
                                                items: list.items.map { oldItem in
                                                    ShoppingItem(
                                                        title: oldItem.title,
                                                        count: oldItem.count,
                                                        unit: oldItem.unit
                                                    )
                                                },
                                                totalAmount: list.totalAmount
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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        navigationMenu
                    }
                }
                
                Spacer()
                
                BaseButton(title: "Создать список", isActive: true) {
                    isShowingCreateSheet = true
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $isShowingCreateSheet) {
                    NavigationStack {
                        CreateEditListView()
                    }
                }
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
    let previewContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: ListItem.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            for list in ListItem.mocks {
                container.mainContext.insert(list)
            }
            return container
        } catch {
            fatalError("Не удалось создать превью-контейнер: \(error)")
        }
    }()
    
    return MainListsView()
        .modelContainer(previewContainer)
}
