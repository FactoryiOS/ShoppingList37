//
//  IconPickerView.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 18.08.2026.
//

import SwiftUI

struct IconPickerView: View {
    
    @Binding var selectedIcon: PickerIcon?
    
    let selectionColor: Color
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var unselectedIconColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 6
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            grid
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }
    
    private var header: some View {
        Text("Выберите дизайн")
            .font(.callout)
            .foregroundStyle(.primary)
    }
    
    private var grid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(PickerIcon.allCases) { icon in
                iconCell(
                    icon,
                    isSelected: selectedIcon == icon
                )
            }
        }
    }
    
    private func iconCell(
        _ icon: PickerIcon,
        isSelected: Bool
    ) -> some View {
        
        let selectedFill = isSelected
            ? selectionColor
            : Color(uiColor: .secondarySystemBackground)
        
        return ZStack {
            Circle()
                .fill(selectedFill)
            
            Image(icon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(
                    isSelected
                        ? .black
                        : unselectedIconColor
                )
        }
        .frame(width: 48, height: 48)
        .contentShape(Circle())
        .onTapGesture {
            selectedIcon = icon
        }
    }
}

#Preview {
    IconPickerView(
        selectedIcon: .constant(nil),
        selectionColor: .blue
    )
    .padding()
}
