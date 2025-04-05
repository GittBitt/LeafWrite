//
//  JournalEntry.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


// Models/JournalEntry.swift
import SwiftUI

struct JournalEntry: Identifiable {
    let id: UUID
    let date: Date
    let text: String
    let image: UIImage?
}
