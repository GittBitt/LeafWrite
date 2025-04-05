//
//  ImagePickerView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

struct ImagePickerView: View {
    let date: Date
    @EnvironmentObject var journalVM: JournalViewModel
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        VStack {
            Button("Take Photo") {
                sourceType = .camera
                showImagePicker = true
            }
            Button("Choose from Library") {
                sourceType = .photoLibrary
                showImagePicker = true
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: sourceType) { image in
                if let image = image {
                    // Process the image using the Vision framework.
                    VisionProcessor.processImage(image) { processedImage in
                        // Save the processed image to the journal entry.
                        journalVM.addImageEntry(for: date, image: processedImage)
                    }
                }
            }
        }
    }
}
