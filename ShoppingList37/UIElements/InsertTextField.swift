//
//  InsertTextField.swift
//  ShoppingList37
//
//  Created by Igor Burkovsky on 16.08.2026.
//

import SwiftUI

struct InsertTextField: View {
    // MARK: - Properties
    @Binding var insertString: String
    @Binding var isError: Bool
    var placeholder: String
    var subtitle: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                TextField(
                    "",
                    text: $insertString,
                    prompt: Text(placeholder)
                        .foregroundStyle(Color.Colors.textInactive)
                )
                .padding(.leading, 16)
                .font(.body)
                .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 38)
                Spacer()
                if insertString.count > 0 {
                    Button {
                        insertString = ""
                    } label: {
                        Image(system: .closeButton)
                            .foregroundStyle(Color.Colors.textInactive)
                            .padding(.trailing, 16)
                    }
                }
            }
            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 54)
            .background(.white)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isError ? Color.Colors.errorMain : .white, lineWidth: 1)
            }
            if isError {
                HStack {
                    Text(subtitle)
                        .font(.footnote)
                        .padding(.horizontal, 8)
                        .foregroundStyle(Color.Colors.errorMain)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    InsertTextField(
        insertString: .constant(""),
        isError: .constant(false),
        placeholder: "Название товара",
        subtitle: "Ошибка ввода"
    )
}
