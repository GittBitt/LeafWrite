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

    // Two-column grid layout
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // State for full screen image display
    @State private var selectedImage: UIImage? = nil
    @State private var showEnlargedImage: Bool = false

    var body: some View {
        ZStack {
            // Light green background
            Color(red: 0.9, green: 1.0, blue: 0.9)
                .ignoresSafeArea()

            ScrollView {
                if imageEntries.isEmpty {
                    Text("No images available")
                        .font(.headline)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(imageEntries) { entry in
                            if let image = entry.image {
                                VStack {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            selectedImage = image
                                            showEnlargedImage = true
                                        }

                                    Text(entry.date, formatter: DateFormatter.mediumStyle)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Gallery")
            .foregroundColor(.black)
        }
        // Sheet for enlarged image
        .sheet(isPresented: $showEnlargedImage) {
            if let image = selectedImage {
                NavigationView {
                    EnlargedImageView(image: image)
                        .navigationBarHidden(true)
                }
            }
        }
    }
}
