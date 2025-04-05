//
//  JournalViewModel.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


// ViewModels/JournalViewModel.swift
import SwiftUI

class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    func entries(for date: Date) -> [JournalEntry] {
        // Return entries that match the specified date.
        let calendar = Calendar.current
        return entries.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    func addEntry(for date: Date, text: String) {
        let entry = JournalEntry(id: UUID(), date: date, text: text, image: nil)
        entries.append(entry)
    }
    
    func addImageEntry(for date: Date, image: UIImage) {
        let entry = JournalEntry(id: UUID(), date: date, text: "Image added", image: image)
        entries.append(entry)
    }
}
