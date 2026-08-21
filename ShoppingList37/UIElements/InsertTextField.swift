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
    var isSearchGlyph: Bool
    var isError: Bool
    var placeholder: String
    var subtitle: String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                searchGlyph
                
                universalTextField
                
                Spacer()
                
                closeButton
            }
            .frame(maxHeight: maxHeightTextFieldFrame)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            }
            
            errorSubtitle
        }
        .padding()
    }
    
    private var searchGlyph: some View {
        VStack {
            if isSearchGlyph {
                Image(system: .magnifyingGlass)
                    .foregroundStyle(.primary)
                    .padding(.leading, 8)
            }
        }
    }
    
    private var universalTextField: some View {
        VStack {
            TextField(
                "",
                text: $insertString,
                prompt: Text(placeholder)
                    .foregroundStyle(Color.Colors.textInactive)
            )
            .padding(.leading, leadingSize)
            .font(.body)
            .frame(maxHeight: maxHeightTextField)
        }
    }
    
    private var errorSubtitle: some View {
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
    
    private var maxHeightTextField: CGFloat {
        isSearchGlyph ? 22 : 38
    }
    
    private var leadingSize: CGFloat {
        isSearchGlyph ? 0 : 16
    }
    
    private var maxHeightTextFieldFrame: CGFloat {
        isSearchGlyph ? 38 : 54
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .Colors.backgroundSecondary : .white
    }
    
    private var borderColor: Color {
        isError ? .Colors.errorMain : backgroundColor
    }
    
    private var closeButton: some View {
        VStack {
            if !isSearchGlyph && insertString.count > 0 {
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
    InsertTextField(
        insertString: .constant(""),
        isSearchGlyph: false,
        isError: false,
        placeholder: "Название товара",
        subtitle: "Ошибка ввода"
    )
}
