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
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.mainState {
                ContentView()
            } else {
                WelcomeScreen {
                    appState.mainState = true
                }
            }
        }
        .modelContainer(for: ListItem.self)
    }
}
