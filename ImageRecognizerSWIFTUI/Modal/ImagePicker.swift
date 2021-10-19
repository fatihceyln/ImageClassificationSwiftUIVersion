//
//  ImagePicker.swift
//  ImageRecognizerSWIFTUI
//
//  Created by Fatih Kilit on 16.10.2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    //When we call ImagePicker struct, we have to pass @StateObject into @ObservedObject imageRecognizer variable.
    @ObservedObject var imageRecognizer: ImageRecognizerViewModal
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                
                parent.selectedImage = image
            }
            
            if let ciImage = CIImage(image: parent.selectedImage) {
                
                parent.imageRecognizer.recognizeImage(image: ciImage)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
