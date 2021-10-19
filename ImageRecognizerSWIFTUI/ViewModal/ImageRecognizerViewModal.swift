//
//  ImageRecognizerViewModal.swift
//  ImageRecognizerSWIFTUI
//
//  Created by Fatih Kilit on 16.10.2021.
//

import Foundation
import SwiftUI
import CoreML
import Vision

class ImageRecognizerViewModal: ObservableObject {
    
    @Published var identifier: String = ""
    @Published var confidenceLevel: Int = 0
    
    func recognizeImage(image: CIImage) {
        
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            
            let request = VNCoreMLRequest(model: model) { vnRequest, error in
                
                if error != nil {
                    print("Error!")
                } else {
                    if let results = vnRequest.results as? [VNClassificationObservation] {
                        
                        if results.count > 0 {
                            
                            let topResult = results.first
                            
                            DispatchQueue.main.async {
                                
                                let identifier = topResult?.identifier ?? ""
                                let confidenceLevel = (topResult?.confidence ?? 0.0) * 100
                                let roundedConfidenceLevel = Int(confidenceLevel.rounded())
                                
                                self.identifier = identifier
                                self.confidenceLevel = roundedConfidenceLevel
                            }
                        }
                    }
                }
            }
            
            let hander = VNImageRequestHandler(ciImage: image)
            
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try hander.perform([request])
                } catch {
                    print("Error!")
                }
            }
        }
    }
}
