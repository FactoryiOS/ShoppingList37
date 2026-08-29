//
//  NavigationRoute.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 29.08.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class NavigationRoute {

    // MARK: - Routes

    enum Route: Hashable, Identifiable {
        case createList
        case editList(listID: UUID)
        case itemsList
        case createProduct
        case editProduct

        var id: String {
            switch self {
            case .createList:
                return "createList"

            case .editList(let listID):
                return "editList_\(listID)"

            case .itemsList:
                return "itemsList"

            case .createProduct:
                return "createProduct"

            case .editProduct:
                return "editProduct"
            }
        }
    }

    // MARK: - State

    var navigationPath: [Route] = []
    var presentingSheet: Route?

    // MARK: - Navigation

    func push(_ route: Route) {
        navigationPath.append(route)
    }

    func pop() {
        guard !navigationPath.isEmpty else {
            return
        }

        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath.removeAll()
    }

    func showModal(_ route: Route) {
        presentingSheet = route
    }
}
