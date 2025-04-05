//
//  Styles.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//
//currently not working

import SwiftUI

//BUTTON STYLES
// Custom Dark Green Button Style
struct DarkGreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.green : Color.green.opacity(0.75))
            .cornerRadius(10)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
