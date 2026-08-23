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
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17, weight: .medium))
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(isActive ? .accent : .Colors.buttonDisabled)
            .foregroundStyle(isActive ? .white : .Colors.textInactive)
            .disabled(!isActive)
            .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
    }
}

#Preview("Active") {
    BaseButton(title: "Добавить товар", isActive: true, action: { print("Нажата активня кнопка") })
}
#Preview("No active") {
    BaseButton(title: "Добавить товар", isActive: false, action: { print("Нажата не активная кнопка") })
}
