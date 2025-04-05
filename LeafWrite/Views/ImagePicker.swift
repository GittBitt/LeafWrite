//
//  ImagePicker.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    var completion: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self, completion: completion)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        let completion: (UIImage?) -> Void

        init(_ parent: ImagePicker, completion: @escaping (UIImage?) -> Void) {
            self.parent = parent
            self.completion = completion
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completion(nil)
            picker.dismiss(animated: true)
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as? UIImage
            completion(image)
            picker.dismiss(animated: true)
        }
    }
}
