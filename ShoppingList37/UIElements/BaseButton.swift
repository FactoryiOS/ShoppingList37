//
//  BaseButton.swift
//  ShoppingList37
//
//  Created by Igor Burkovsky on 16.08.2026.
//

import SwiftUI

struct BaseButton: View {
    // MARK: - Properties
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .frame(width: 303, height: 22)
            }
            .padding()
            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 44)
            .background(isActive ? .accent : Color.Colors.buttonDisabled)
            .foregroundStyle(isActive ? .white : Color.Colors.textInactive)
            .disabled(!isActive)
            .cornerRadius(100)
        }
    }
}

#Preview {
    BaseButton(title: "Добавить товар", isActive: true, action: { print("Нажата кнопка") } )
}
