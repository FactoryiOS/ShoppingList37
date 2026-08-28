//
//  WelcomeScreen.swift
//  ShoppingList37
//

import SwiftUI

struct WelcomeScreen: View {

    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            Text(TextConstants.welcomeTitle)
                .font(.system(size: 34, weight: .regular))
            Image(.Images.imgOnboardingFirst)
                .padding(.top, 48)
            Text(TextConstants.description)
                .font(.system(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 48)
            Text(TextConstants.createLists)
                .font(.system(size: 17, weight: .regular))
                .padding(.top, 12)
            Text(TextConstants.doNotWorry)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            BaseButton(title: TextConstants.startButton, isActive: true) {
                onComplete()
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
    }
}

private enum TextConstants {
    static let welcomeTitle = "Добро пожаловать!"
    static let description = "Никогда не забывайте, что нужно купить"
    static let createLists = "Создавайте списки"
    static let doNotWorry = "и не переживайте о покупках"
    static let startButton = "Начать"
}

#Preview {
    WelcomeScreen() {
        print("Button clicked!")
    }
}
