//
//  ForageCameraView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI
import AVFoundation

struct ForageCameraView: View {
    @EnvironmentObject var journalVM: JournalViewModel
    @StateObject private var cameraManager = CameraManager()
    @State private var capturedImage: UIImage? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Live camera preview.
                CameraPreview(session: cameraManager.session)
                    .ignoresSafeArea()
                
                // Overlay live detection bounding boxes.
                ForEach(cameraManager.detectionResults) { detection in
                    BoundingBoxView(detection: detection, geometry: geo)
                }
                
                
                VStack {
                    HStack {
                        Spacer()
                        // Button to switch between cameras.
                        Button(action: {
                            cameraManager.switchCamera()
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .font(.title)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Capture button to save a still image.
                    Button(action: capturePhoto) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 70, height: 70)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    }
                    .padding(.bottom, 30)
                }
            }
            .onAppear {
                cameraManager.session.startRunning()
            }
            .onDisappear {
                cameraManager.session.stopRunning()
            }
        }
    }
    
    private func capturePhoto() {
        cameraManager.capturePhoto { image in
            guard let image = image else {
                print("❌ No image captured")
                return
            }
            print("✅ Image captured!")
            DispatchQueue.main.async {
                self.journalVM.addImageEntry(for: Date(), image: image)
                print("✅ Entry count: \(self.journalVM.entries.count)")
            }
        }
    }
}

//struct BoundingBoxView: View {
//    let detection: DetectionResult
//    let geometry: GeometryProxy
//    
//    var body: some View {
//        // Convert the normalized bounding box to the view’s coordinate system.
//        let box = detection.boundingBox
//        let x = box.minX * geometry.size.width
//        let y = (1 - box.maxY) * geometry.size.height // Vision coordinate system: origin at bottom left.
//        let width = box.width * geometry.size.width
//        let height = box.height * geometry.size.height
//        
//        return ZStack(alignment: .topLeading) {
//            Rectangle()
//                .stroke(Color.red, lineWidth: 2)
//                .frame(width: width, height: height)
//                .position(x: x + width / 2, y: y + height / 2)
//            
//            Text(detection.label)
//                .font(.caption)
//                .foregroundColor(.red)
//                .padding(4)
//                .background(Color.white.opacity(0.7))
//                .position(x: x + 40, y: y)
//        }
//    }
//}

struct ForageCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ForageCameraView()
            .environmentObject(JournalViewModel())
    }
}
