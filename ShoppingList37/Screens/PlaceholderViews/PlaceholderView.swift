//
// PlaceholderView.swift
//  ShoppingList37
//

import SwiftUI

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
        
    var imageSize: CGFloat {
        switch self {
        case .shoppingList:
            return 343
        case .mainScreen:
            return 277
        }
    }
}

// MARK: - Placeholder View

struct PlaceholderView: View {
    
    let state: EmptyStateData
    
    var body: some View {
        VStack {
            Image(state.imageResource)
                .resizable()
                .frame(width: state.imageSize, height: state.imageSize)
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

#Preview {
    PlaceholderView(state: .shoppingList)
}
