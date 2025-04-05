//
//  CameraManager.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


// Managers/CameraManager.swift
import AVFoundation
import UIKit

class CameraManager: ObservableObject {
    let session = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    
    init() {
        setupSession()
    }
    
    func setupSession() {
        session.beginConfiguration()
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                        for: .video,
                                                        position: .back),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
              session.canAddInput(videoInput)
        else { return }
        session.addInput(videoInput)
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        session.commitConfiguration()
        session.startRunning()
    }
    
    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings,
                                 delegate: PhotoCaptureProcessor(completion: completion))
    }
}

class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
    let completion: (UIImage?) -> Void
    
    init(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            completion(nil)
            return
        }
        completion(image)
    }
}
