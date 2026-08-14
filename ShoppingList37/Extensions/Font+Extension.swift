//
//  Font+Extension.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 14.08.26.
//

import SwiftUI

extension Font {
    // Главные крупные заголовки на экранах (из раздела LargeTitle)
    static let appLargeTitle = Font.system(size: 34, weight: .bold)
    
    // Заголовки разделов (из раздела Title1)
    static let appTitle = Font.system(size: 28, weight: .semibold)
    
    // Акцентный текст и заголовки ячеек (из раздела Headline)
    static let appHeadline = Font.system(size: 17, weight: .semibold)
    
    // Основной текст приложения (из раздела Body)
    static let appBody = Font.system(size: 17, weight: .regular)
    
    // Мелкий текст, подписи и сноски (из раздела Caption1)
    static let appCaption = Font.system(size: 12, weight: .regular)
}
