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
                .navigationDestination(
                    for: NavigationRoute.Route.self
                ) { route in
                    getScreen(for: route)
                }
        }
        .sheet(item: $router.presentingSheet) { route in
            getScreen(for: route)
        }
        .environment(router)
    }
    
    @ViewBuilder
    private func getScreen(
        for route: NavigationRoute.Route
    ) -> some View {
        switch route {
        case .createList:
            CreateEditListView()
            
        case .editList:
            if let list = router.selectedList {
                CreateEditListView(
                    existingList: list,
                    initialString: list.name,
                    initialColor: list.color,
                    initialIcon: list.icon
                )
            }
        case .itemsList:
            if let list = router.selectedList {
                ItemsListView(list: list)
            }
            
        case .createProduct:
            if let list = router.selectedList {
                ProductView(
                    mode: .create,
                    list: list,
                    existingItem: nil
                )
            }
            
        case .editProduct:
            if let list = router.selectedList,
               let item = router.selectedItem {
                ProductView(
                    mode: .edit,
                    list: list,
                    existingItem: item
                )
            }
        }
    }
}

#Preview {
    RouteView()
}
