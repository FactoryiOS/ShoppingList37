//
//  MainListsView.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 26.08.26.
//
import SwiftUI

struct MainListsView: View {

    @Environment(NavigationRoute.self) private var router

    @State private var lists: [ListItem]

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
                Label(
                    "Установить тему",
                    systemImage: themeIcon
                )
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }

    init(initialLists: [ListItem] = ListItem.mocks) {
        _lists = State(initialValue: initialLists)
    }

    var body: some View {
        VStack {
            Group {
                if lists.isEmpty {
                    PlaceholderView(state: .mainScreen)
                } else {
                    List {
                        ForEach(lists) { list in
                            ListCellView(item: list)
                                .contentShape(Rectangle())
                                .onTapGesture {
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

            BaseButton(
                title: "Создать список",
                isActive: true
            ) {
                router.push(.createList)
            }
            .padding(.bottom, 20)
        }
        .background(Color.Colors.backgroundMain)
    }
}

#Preview("Empty") {
    NavigationStack {
        MainListsView(initialLists: [])
    }
    .environment(NavigationRoute())
}

#Preview("Data") {
    NavigationStack {
        MainListsView(initialLists: ListItem.mocks)
    }
    .environment(NavigationRoute())
}
