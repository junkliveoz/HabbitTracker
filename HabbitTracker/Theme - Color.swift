//
//  Theme - Color.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

struct DarkModeViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(.dark)
            .background(Color.darkGray.edgesIgnoringSafeArea(.all))
    }
}

extension View {
    func darkModeStyle() -> some View {
        self.modifier(DarkModeViewModifier())
    }
}


extension ShapeStyle where Self == Color {
    static var darkGray: Color {
        Color(red: 37/255, green: 36/255, blue: 34/255)
    }
    
    static var deepOrange: Color {
        Color(red: 235/255, green: 94/255, blue: 40/255)
    }
    
    static var mediumGray: Color {
        Color(red: 64/255, green: 61/255, blue: 57/255)
    }
    
    static var lightGray: Color {
        Color(red: 204/255, green: 197/255, blue: 185/255)
    }
    static var offWhite: Color {
        Color(red: 255/255, green: 252/255, blue: 242/255)
    }
}
