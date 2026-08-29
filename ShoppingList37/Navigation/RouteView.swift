//
//  RouteView.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 29.08.2026.
//

import SwiftUI

struct RouteView: View {

    @State private var router = NavigationRoute()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            MainListsView()
                .navigationDestination(for: NavigationRoute.Route.self) { route in
                    getScreen(for: route)
                }
        }
        .sheet(item: $router.presentingSheet) { route in
            getScreen(for: route)
        }
        .environment(router)
    }

    @ViewBuilder
    private func getScreen(for route: NavigationRoute.Route) -> some View {
        switch route {
        case .createList:
            CreateEditListView()

        case .editList(let listID):
            CreateEditListView(existingListId: listID)

        case .itemsList:
            ItemsListView()

        case .createProduct:
            ProductView(mode: .create)

        case .editProduct:
            ProductView(mode: .edit)
        }
    }
}

#Preview {
    RouteView()
}
