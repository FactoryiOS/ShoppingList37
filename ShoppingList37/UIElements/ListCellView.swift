//
//  ListCellView.swift
//  ShoppingList37
//
//  Created by Андрей Урсан on 24.08.2026.
//

import SwiftUI

struct ListCellView: View {

    let item: ListItem
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                avatarField

                Text(item.name)
                    .font(.title3)
                    .foregroundStyle(Color.Colors.textPrimary)
                    .lineLimit(1)

                Spacer()

                counterField
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 84, alignment: .leading)
            .background(Color.Colors.backgroundSecondary)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Avatar

    private var avatarField: some View {
        ZStack {
            Circle()
                .fill(item.color.color)

            item.icon.image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.black)
        }
        .frame(width: 48, height: 48)
    }

    // MARK: - Counter

    private var counterField: some View {
        HStack(spacing: 1) {
            Text("\(item.amount)")
                .font(.body)
                .foregroundStyle(Color.Colors.textPrimary)

            Text("/")
                .font(.body)
                .foregroundStyle(Color.Colors.textPrimary)

            Text("\(item.totalAmount)")
                .font(.subheadline)
                .foregroundStyle(Color.Colors.textPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
    }
}

#Preview {
    ZStack {
        Color.Colors.backgroundMain
            .ignoresSafeArea()

        ListCellView(item: .mock) {
            print("Tapped")
        }
        .padding()
    }
}
