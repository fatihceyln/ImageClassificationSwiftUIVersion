//
//  ContentView.swift
//  ImageRecognizerSWIFTUI
//
//  Created by Fatih Kilit on 16.10.2021.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedImage: UIImage = UIImage()
    @State var chnageImage = false
    @State var openLibrary: Bool = false
    
    // Init ImageRecognizerViewModal
    @StateObject var imageRecognizer: ImageRecognizerViewModal = ImageRecognizerViewModal()
    
    var body: some View {
        
        ZStack
        {
            Color.purple
                .ignoresSafeArea()
            
            VStack (spacing: 20)
            {
                Button {
                    
                    openLibrary = true
                    chnageImage = true
                    
                } label: {
                    if chnageImage {
                        Image(uiImage: selectedImage)
                            .imageMode()
                        
                    } else {
                        Image(systemName: "photo.fill")
                            .imageMode()
                    }
                    
                    
                }
                .sheet(isPresented: $openLibrary) {
                    ImagePicker(selectedImage: $selectedImage, imageRecognizer: imageRecognizer)
                }
                
                Text("It's %\(imageRecognizer.confidenceLevel) \(imageRecognizer.identifier)")
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .background(Color.black)
                    .cornerRadius(20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
