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
    var isError: Bool
    var placeholder: String
    var subtitle: String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                universalTextField()
                
                Spacer()
                
                closeButton()
            }
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            }
            
            errorSubtitle()
        }
        .padding()
    }
    
    private func universalTextField() -> some View {
        VStack {
            TextField(
                "",
                text: $insertString,
                prompt: Text(placeholder)
                    .foregroundStyle(Color.Colors.textInactive)
            )
            .padding(.leading, 16)
            .padding(.vertical, 12)
            .font(.body)
        }
    }
    
    private func errorSubtitle() -> some View {
        VStack {
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
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .Colors.backgroundSecondary : .white
    }
    
    private var borderColor: Color {
        isError ? .Colors.errorMain : backgroundColor
    }
    
    private func closeButton() -> some View {
        VStack {
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
    }
}

#Preview {
    @Previewable @State var productName: String = ""
    @Previewable @State var isError: Bool = false
    let placeholder = "Введите наименование товара"
    let subtitleTextField = "Это название уже используется"
    let titleButton = "Добавить товар"

    ZStack {
        Color.Colors.backgroundMain.ignoresSafeArea()
        VStack {
            InsertTextField(
                insertString: $productName,
                isError: isError,
                placeholder: placeholder,
                subtitle: subtitleTextField
            )
            .onChange(of: productName) { _, newValue in
                isError = newValue == "Тест"
            }
            
            Spacer()
            
            BaseButton(title: titleButton, isActive: !productName.isEmpty && !isError) { }
        }
    }
}
