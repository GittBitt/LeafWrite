//
//  LeafWriteApp.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

@main
struct LeafWriteApp: App {
    @StateObject private var journalVM = JournalViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(JournalViewModel())
//                .environmentObject(ThemeManager())
                .environmentObject(journalVM)
        }
    }
}

