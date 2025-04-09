//
//  LiveDetectionCameraView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import AVFoundation

struct LiveDetectionCameraView: View {
    @StateObject private var cameraManager = CameraManager()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Live camera preview.
                CameraPreview(session: cameraManager.session)
                    .ignoresSafeArea()
                
                // Overlay detected bounding boxes and labels.
                ForEach(cameraManager.detectionResults, id: \.boundingBox) { detection in
                    BoundingBoxView(detection: detection, geometry: geo)
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
}

struct BoundingBoxView: View {
    let detection: DetectionResult
    let geometry: GeometryProxy
    
    var body: some View {
        // Convert normalized coordinates [0,1] to view coordinates.
        let box = detection.boundingBox
        let x = box.minX * geometry.size.width
        // Vision's coordinate system has origin at bottom-left so invert y.
        let y = (1 - box.maxY) * geometry.size.height
        let width = box.width * geometry.size.width
        let height = box.height * geometry.size.height
        
        return ZStack(alignment: .topLeading) {
            Rectangle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: width, height: height)
                .position(x: x + width / 2, y: y + height / 2)
            
            Text(detection.label)
                .font(.caption)
                .foregroundColor(.red)
                .padding(4)
                .background(Color.white.opacity(0.7))
                .position(x: x + 40, y: y)
        }
    }
}

struct LiveDetectionCameraView_Previews: PreviewProvider {
    static var previews: some View {
        LiveDetectionCameraView()
    }
}
