//
//  CameraManager.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import AVFoundation
import UIKit
import Combine
import Vision
import CoreML

// Structure to hold a detection result.
struct DetectionResult: Identifiable {
    let id = UUID()         // Unique identifier
    let boundingBox: CGRect // Normalized [0, 1] rectangle
    let label: String
}


class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var currentInput: AVCaptureDeviceInput?
    private var orientationObserver: AnyCancellable?
    
    // Published detection results from live video.
    @Published var detectionResults: [DetectionResult] = []
    
    // Time stamp for throttling frame processing.
    private var lastAnalysisTime = Date(timeIntervalSince1970: 0)
    
    // Vision request using YOLOv3.
    private var visionRequest: VNCoreMLRequest?
    
    private var photoCaptureProcessor: PhotoCaptureProcessor?
    
    override init() {
        super.init()
        configureSession()
        observeOrientation()
        setupVision()
    }
    
    private func setupVision() {
        do {
            // Ensure you have added YOLOv3.mlmodel to your project.
            let model = try VNCoreMLModel(for: YOLOv3().model)
            visionRequest = VNCoreMLRequest(model: model, completionHandler: visionRequestDidComplete)
            // Use scaleFill so the model sees the full image.
            visionRequest?.imageCropAndScaleOption = .scaleFill
        } catch {
            print("❌ Failed to load YOLOv3 model: \(error)")
        }
    }
    
    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        // Add camera input (back camera by default).
        if let input = getCameraInput(isFront: false), session.canAddInput(input) {
            session.addInput(input)
            currentInput = input
        }
        
        // Add photo output for still image capture.
        if session.canAddOutput(photoOutput) {
            print("add photoOutput")
            session.addOutput(photoOutput)
        }
        
        // Add video data output for live processing.
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoDataQueue"))
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        session.commitConfiguration()
        session.startRunning()
    }
    
    func switchCamera() {
        guard let currentInput = currentInput else { return }
        session.beginConfiguration()
        session.removeInput(currentInput)
        
        // Toggle camera position.
        let isFront = (currentInput.device.position == .back)
        if let newInput = getCameraInput(isFront: isFront), session.canAddInput(newInput) {
            session.addInput(newInput)
            self.currentInput = newInput
        }
        session.commitConfiguration()
    }
    
    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        if photoOutput.supportedFlashModes.contains(.auto) {
            settings.flashMode = .auto
        }
        
        photoCaptureProcessor = PhotoCaptureProcessor { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
            photoOutput.capturePhoto(with: settings, delegate: photoCaptureProcessor!
        )
    }
    
    private func getCameraInput(isFront: Bool) -> AVCaptureDeviceInput? {
        let position: AVCaptureDevice.Position = isFront ? .front : .back
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                    for: .video,
                                                    position: position) else { return nil }
        return try? AVCaptureDeviceInput(device: device)
    }
    
    private func observeOrientation() {
        orientationObserver = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { _ in
                print("🔄 Device rotated: \(UIDevice.current.orientation.rawValue)")
            }
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        // Throttle processing to once every 0.5 seconds.
        let currentTime = Date()
        guard currentTime.timeIntervalSince(lastAnalysisTime) >= 0.5 else { return }
        lastAnalysisTime = currentTime
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
              let visionRequest = visionRequest else { return }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        do {
            try handler.perform([visionRequest])
        } catch {
            print("❌ Vision error: \(error)")
        }
    }
    
    // MARK: - Vision Completion
    private func visionRequestDidComplete(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedObjectObservation] else {
            DispatchQueue.main.async { self.detectionResults = [] }
            return
        }
        
        // Map the observations to DetectionResult (using the top label from each observation).
        let detections = results.compactMap { observation -> DetectionResult? in
            guard let topLabel = observation.labels.first?.identifier else { return nil }
            return DetectionResult(boundingBox: observation.boundingBox, label: topLabel)
        }
        DispatchQueue.main.async {
            self.detectionResults = detections
        }
    }
}
