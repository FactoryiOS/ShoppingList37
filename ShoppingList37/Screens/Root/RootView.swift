//
//  RootView().swift
//  ShoppingList37
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(
        filter: #Predicate<AppState> {
            $0.identifier == "main_state"
        }
    )
    
    private var appStates: [AppState]
    
    private var appState: AppState? {
        appStates.first
    }
    
    var body: some View {
        Group {
            if appState?.isWelcomeCompleted == true {
                ContentView()
            } else {
                WelcomeScreen {
                    completeWelcome()
                }
            }
        }
        .task {
            createAppStateIfNeeded()
        }
    }
    
    private func createAppStateIfNeeded() {
        guard appStates.isEmpty else { return }
        
        modelContext.insert(AppState())
        
        do {
            try modelContext.save()
        } catch {
            assertionFailure("Failed to save AppState: \(error)")
        }
    }
    
    private func completeWelcome() {
        guard let appState else { return }
        
        appState.isWelcomeCompleted = true
        
        do {
            try modelContext.save()
        } catch {
            assertionFailure("Failed to save AppState: \(error)")
        }
    }
}
