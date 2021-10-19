//
//  ImageProperties.swift
//  ImageRecognizerSWIFTUI
//
//  Created by Fatih Kilit on 16.10.2021.
//

import SwiftUI

extension Image {
    
    func imageMode() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350, height: 350)
            .padding()
            .shadow(color: .gray, radius: 50)
    }
}
