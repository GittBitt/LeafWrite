//
//  VisionProcessor.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


// Processors/VisionProcessor.swift
import Foundation
import Vision
import CoreML
import UIKit

class VisionProcessor {
    static func processImage(_ image: UIImage, completion: @escaping (UIImage) -> Void) {
        guard let cgImage = image.cgImage else {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                print("Vision error: \(error)")
                DispatchQueue.main.async { completion(image) }
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                DispatchQueue.main.async { completion(image) }
                return
            }
            let processedImage = drawObservations(on: image, observations: observations)
            DispatchQueue.main.async {
                completion(processedImage)
            }
        }
        request.recognitionLevel = .accurate
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Vision error: \(error)")
                DispatchQueue.main.async { completion(image) }
            }
        }
    }
    
    private static func drawObservations(on image: UIImage,
                                         observations: [VNRecognizedTextObservation]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
        image.draw(at: .zero)
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2.0)
        
        for observation in observations {
            let box = observation.boundingBox
            let rect = CGRect(
                x: box.minX * image.size.width,
                y: (1 - box.maxY) * image.size.height,
                width: box.width * image.size.width,
                height: box.height * image.size.height
            )
            context.stroke(rect)
        }
        let processedImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return processedImage
    }
}
