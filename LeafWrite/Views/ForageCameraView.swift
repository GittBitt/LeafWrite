//
//  ForageCameraView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI
import AVFoundation
import Vision
import CoreML

struct ForageCameraView: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var capturedImage: UIImage? = nil
    @State private var recognizedResults: String = ""
    @State private var showResults = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            // Live camera preview.
            CameraPreview(session: cameraManager.session)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // Capture button.
                Button(action: {
                    cameraManager.capturePhoto { image in
                        if let image = image {
                            capturedImage = image
                            //classifyImage(image)
                        }
                    }
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
                .padding(.bottom, 20)
            }
        }
        // Present results in a sheet.
        .sheet(isPresented: $showResults) {
            ForageResultsView(results: recognizedResults, image: capturedImage)
        }
    }
    
//    private func classifyImage(_ image: UIImage) {
//        guard let cgImage = image.cgImage else { return }
//        do {
//            // Use YOLOv3 model.
//            // Make sure YOLOv3.mlmodel is added to your project.
//            let model = try VNCoreMLModel(for: YOLOv3(configuration: MLModelConfiguration()).model)
//            let request = VNCoreMLRequest(model: model) { request, error in
//                if let results = request.results as? [VNRecognizedObjectObservation] {
//                    // Process the observations. For example, extract labels and confidence.
//                    let detectedObjects = results.map { observation -> String in
//                        let identifier = observation.labels.first?.identifier ?? "Unknown"
//                        let confidence = observation.labels.first?.confidence ?? 0.0
//                        return "\(identifier) (\(Int(confidence * 100))%)"
//                    }
//                    let labels = detectedObjects.joined(separator: ", ")
//                    // Simulated API call to lookup foraged flora and fauna.
//                    let lookup = lookupFloraFauna(for: labels)
//                    DispatchQueue.main.async {
//                        recognizedResults = lookup
//                        showResults = true
//                    }
//                }
//            }
//            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//            try handler.perform([request])
//        } catch {
//            print("Error during classification: \(error)")
//        }
//    }
    
    // Simulated API lookup function.
    private func lookupFloraFauna(for labels: String) -> String {
        // Replace with your actual API call.
        return "Foraged flora/fauna: \(labels)"
    }
}

struct ForageCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ForageCameraView()
    }
}
