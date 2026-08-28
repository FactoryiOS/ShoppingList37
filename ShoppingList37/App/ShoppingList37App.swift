//
//  ShoppingList37App.swift
//  ShoppingList37
//
//  Created by Nikita Tsomuk on 10.08.2026.
//

import SwiftUI

@main
struct ShoppingList37App: App {
    @StateObject private var appState = AppState()
    
    @AppStorage("appScheme")
    
    private var appScheme = AppScheme.system.rawValue
    
    private var colorScheme: ColorScheme? {
        switch AppScheme(rawValue: appScheme) ?? .system {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.mainState {
                MainListsView()
                    .preferredColorScheme(colorScheme)
            } else {
                WelcomeScreen {
                    appState.mainState = true
                }
            }
        }
    }
}
