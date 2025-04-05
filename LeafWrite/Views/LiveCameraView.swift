//
//  LiveCameraView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI
import AVFoundation

struct LiveCameraView: View {
    @StateObject var cameraManager = CameraManager()
    @State private var capturedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CameraView(session: cameraManager.session)
                .ignoresSafeArea()
            Button(action: {
                cameraManager.capturePhoto { image in
                    if let image = image {
                        // Process the captured image using Vision.
                        VisionProcessor.processImage(image) { processedImage in
                            // For example, you might save this image to your journal or display it.
                            capturedImage = processedImage
                        }
                    }
                }
            }) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 70, height: 70)
                    .padding()
            }
        }
        .navigationTitle("Live Camera")
    }
}

struct CameraView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var previewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {}
}
