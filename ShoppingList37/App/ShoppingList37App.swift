//
//  ShoppingList37App.swift
//  ShoppingList37
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI
import SwiftData

@main
struct ShoppingList37App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: AppState.self)
    }
}
