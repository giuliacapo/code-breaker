//
//  ColorExtension.swift
//  CodeBreaker
//
//  Created by giulia on 29/09/2026.
//

import Foundation

import SwiftUI

extension Color {
    // 1. Inizializzatore fallibile: converte una stringa in un Color di SwiftUI
    init?(name: String) {
        switch name.lowercased() {
        case "red": self = .red
        case "blue": self = .blue
        case "green": self = .green
        case "yellow": self = .yellow
        case "orange": self = .orange
        case "purple": self = .purple
        case "pink": self = .pink
        case "brown": self = .brown
        case "black": self = .black
        case "white": self = .white
        case "gray", "grey": self = .gray
        case "cyan": self = .cyan
        case "mint": self = .mint
        case "indigo": self = .indigo
        case "teal": self = .teal
        default: return nil // Se la stringa non è un colore valido, fallisce e restituisce nil
        }
    }
    
    // 2. Proprietà opzionale per fare l'inverso (da Color a String, come suggerito dalla challenge)
    var name: String? {
        switch self {
        case .red: return "red"
        case .blue: return "blue"
        case .green: return "green"
        case .yellow: return "yellow"
        case .orange: return "orange"
        case .purple: return "purple"
        case .pink: return "pink"
        case .brown: return "brown"
        case .black: return "black"
        case .white: return "white"
        case .gray: return "gray"
        case .cyan: return "cyan"
        case .mint: return "mint"
        case .indigo: return "indigo"
        case .teal: return "teal"
        default: return nil
        }
    }
    
    static func gray(_ brightness: CGFloat)-> Color{
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}
extension Animation{
    static let codeBreaker = Animation.default
    static let guess = Animation.codeBreaker
    static let restart = Animation.codeBreaker
    static let selection = Animation.codeBreaker
}
extension AnyTransition{
    static let pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ isOver: Bool)-> AnyTransition{
        AnyTransition.asymmetric(
            insertion: isOver ? .opacity : .move(edge: .top),
            removal: .move(edge: .trailing))
    }
}
extension View{
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80)-> some View{
        self
            .font(.system(size: maximum))
            .minimumScaleFactor(minimum/maximum)
    }
}

