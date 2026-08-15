//
//  Font+Extension.swift
//  ShoppingList37
//
//  Created by Kristina Kostenko on 14.08.26.
//

import SwiftUI

extension Font {
    // Главные крупные заголовки на экранах (из раздела LargeTitle)
    static let largeTitle = Font.system(size: 34, weight: .bold)
    
    // Заголовки разделов (из раздела Title1)
    static let title1 = Font.system(size: 28, weight: .semibold)
    
    // Акцентный текст и заголовки ячеек (из раздела Headline)
    static let headline = Font.system(size: 17, weight: .semibold)
    
    // Основной текст приложения (из раздела Body)
    static let body = Font.system(size: 17, weight: .regular)
    
    // Мелкий текст, подписи и сноски (из раздела Footnote)
    static let footnote = Font.system(size: 13, weight: .regular)
}
