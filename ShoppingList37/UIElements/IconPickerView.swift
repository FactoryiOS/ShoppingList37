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
        .background(Color.Colors.backgroundSecondary)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }

    // MARK: - Header

    private var header: some View {
        Text("Выберите дизайн")
            .font(.callout)
            .foregroundStyle(.primary)
    }

    // MARK: - Grid

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

    // MARK: - Icon Cell

    private func iconCell(
        _ icon: PickerIcon,
        isSelected: Bool
    ) -> some View {

        let selectedFill = isSelected
            ? selectionColor
            : Color.Colors.iconBackground

        return ZStack {
            Circle()
                .fill(selectedFill)

            icon.image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(
                    isSelected
                        ? .black
                        : Color.Colors.backgroundSecondary
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
