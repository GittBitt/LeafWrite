//
//  EntryView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI
import Foundation

struct EntryView: View {
    let date: Date
    @State private var newMessage: String = ""
    
    // State variables for image picker and enlarged image presentation.
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showEnlargedImage: Bool = false
    
    @EnvironmentObject var journalVM: JournalViewModel
    
    var body: some View {
        VStack {
            // Chat-like message area.
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(journalVM.entries(for: date), id: \.id) { entry in
                        if let image = entry.image {
                            // Image message bubble.
                            HStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(10)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        // When tapped, store the image and show the enlarged view.
                                        selectedImage = image
                                        showEnlargedImage = true
                                    }
                                Spacer()
                            }
                        } else {
                            // Text message bubble.
                            HStack {
                                Text(entry.text)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            
            // Input area for sending text messages.
            HStack {
                // Add image button on the left.
                Button(action: {
                    showActionSheet = true
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
                
                // TextField for entering a message.
                TextField("Enter message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Send message button.
                Button(action: {
                    if !newMessage.isEmpty {
                        journalVM.addEntry(for: date, text: newMessage)
                        newMessage = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle("Entry - \(date, formatter: DateFormatter.mediumStyle)")
        // ActionSheet to choose the image source.
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Add Photo"), message: Text("Choose a source"), buttons: [
                .default(Text("Take Photo")) {
                    sourceType = .camera
                    showImagePicker = true
                },
                .default(Text("Choose from Library")) {
                    sourceType = .photoLibrary
                    showImagePicker = true
                },
                .cancel()
            ])
        }
        // Present the ImagePicker sheet.
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: sourceType) { image in
                if let image = image {
                    // Process the image using Vision before adding.
                    VisionProcessor.processImage(image) { processedImage in
                        journalVM.addImageEntry(for: date, image: processedImage)
                    }
                }
                showImagePicker = false
            }
        }
        // Present the enlarged image view wrapped in a NavigationView.
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

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(date: Date())
            .environmentObject(JournalViewModel())
    }
}

extension DateFormatter {
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
