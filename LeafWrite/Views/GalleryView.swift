//
//  GalleryView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var journalVM: JournalViewModel
    
    // Filter entries that have an image.
    var imageEntries: [JournalEntry] {
        journalVM.entries.filter { $0.image != nil }
    }
    
    // Define two flexible columns for the grid layout.
    let columns: [GridItem] = [
         GridItem(.flexible()),
         GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Set the overall background to a light green color.
            Color(red: 0.9, green: 1.0, blue: 0.9)
                .ignoresSafeArea()
            ScrollView {
                if imageEntries.isEmpty {
                    Text("No images available")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(imageEntries) { entry in
                            if let image = entry.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipped()
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Gallery")
        }
    }
}
