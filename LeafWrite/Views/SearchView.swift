//
//  SearchView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @EnvironmentObject var journalVM: JournalViewModel
    @State private var searchText: String = ""
    
    // Filter entries based on the search text.
    var filteredEntries: [JournalEntry] {
        if searchText.isEmpty {
            return journalVM.entries
        } else {
            return journalVM.entries.filter { entry in
                entry.text.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Set the overall background to a light green color.
            Color(red: 0.9, green: 1.0, blue: 0.9)
                .ignoresSafeArea()
            VStack {
                TextField("Search entries...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(filteredEntries, id: \.id) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.text)
                            .font(.headline)
                        Text("\(entry.date, formatter: DateFormatter.mediumStyle)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Search Entry")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(JournalViewModel())
    }
}

