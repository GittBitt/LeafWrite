//
//  LeafWriteApp.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

@main
struct LeafWriteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(JournalViewModel())
                .environmentObject(ThemeManager())
        }
    }
}

