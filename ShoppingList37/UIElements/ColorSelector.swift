//
//  ColorSelector.swift
//  ShoppingList37
//
//  Created by Irina Muravyeva on 18.08.2026.
//

import SwiftUI

enum ColorSectionText: String {
    case create = "Выберите цвет"
    case edit = "Цвет"
}

struct ColorSelector: View {
    @State private var selectedColor: ColorOption?
    
    var colorSectionText: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(colorSectionText)
                .font(.iosCalloutRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            HStack(spacing: 12) {
                ForEach(ColorOption.allCases, id: \.self) { colorOption in
                    
                    Button {
                        selectedColor = colorOption
                    } label: {
                        Circle()
                            .fill(colorOption.color)
                            .frame(width: 40, height: 40)
                            .overlay {
                                if selectedColor == colorOption {
                                    Circle()
                                        .stroke(Color.accent, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                }
                            }
                    }
                    .frame(width: 48, height: 48)
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
        }
        .padding()
        .background(Color.Colors.backgroundSecondary)
    }
}

#Preview("Create list") {
    ColorSelector(colorSectionText: ColorSectionText.create.rawValue)
}

#Preview("Edit list") {
    ColorSelector(colorSectionText: ColorSectionText.edit.rawValue)
}
