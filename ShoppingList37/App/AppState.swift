//
//  AppState.swift
//  ShoppingList37
//

import SwiftUI
import Combine

final class AppState: ObservableObject {
    @AppStorage("mainState") var mainState: Bool =  false
}
