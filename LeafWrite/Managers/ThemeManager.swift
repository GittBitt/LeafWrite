//
//  ThemeManager.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


// Managers/ThemeManager.swift
import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: ColorScheme? = .light
    
    func toggleTheme() {
        currentTheme = (currentTheme == .light) ? .dark : .light
    }
}
