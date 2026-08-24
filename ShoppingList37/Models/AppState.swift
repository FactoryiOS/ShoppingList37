//
//  AppState.swift
//  ShoppingList37
//

import SwiftData

@Model
final class AppState {
    
    @Attribute(.unique)
    var identifier: String
    
    var isWelcomeCompleted: Bool
    
    init(
        identifier: String = "main_state",
        isWelcomeCompleted: Bool = false
    ) {
        self.identifier = identifier
        self.isWelcomeCompleted = isWelcomeCompleted
    }
}
