//
//  EnlargedImageView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


import SwiftUI

struct EnlargedImageView: View {
    let image: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Display the image full-screen.
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .padding()
            
            // Back button in the top-left corner.
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct EnlargedImageView_Previews: PreviewProvider {
    static var previews: some View {
        EnlargedImageView(image: UIImage(systemName: "photo")!)
    }
}

