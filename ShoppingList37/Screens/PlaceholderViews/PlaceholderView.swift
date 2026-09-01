//
// PlaceholderView.swift
//  ShoppingList37
//

import SwiftUI

// MARK: - Placeholder View
struct PlaceholderView: View {
    let state: EmptyStateData
    
    var body: some View {
        VStack {
            Image(state.imageResource)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, state.imageHorizontalPadding)
            Text(state.title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 28)
            Text(state.subtitle)
                .font(.body)
                .padding(.top, 4)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Empty State Data
enum EmptyStateData {
    case shoppingList
    case mainScreen
    
    var imageResource: ImageResource {
        switch self {
        case .shoppingList:
            return .Images.imgEmptyItems
        case .mainScreen:
            return .Images.imgEmptyLists
        }
    }
    
    var title: String {
        switch self {
        case .shoppingList, .mainScreen:
            return "Давайте спланируем покупки!"
        }
    }
        
    var subtitle: String {
        switch self {
        case .shoppingList:
            return "Начните добавлять товары"
        case .mainScreen:
            return "Создайте свой первый список"
        }
    }
        
    var imageHorizontalPadding: CGFloat {
        switch self {
        case .shoppingList:
            return 16
        case .mainScreen:
            return 49
        }
    }
}

#Preview("Main Screen") {
    PlaceholderView(state: .mainScreen)
}

#Preview("Shopping List") {
    PlaceholderView(state: .shoppingList)
}
