//
//  ForageResultsView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//


import SwiftUI

struct ForageResultsView: View {
    let results: String
    let image: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.9, green: 1.0, blue: 0.9)
                    .ignoresSafeArea()
                VStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    Text(results)
                        .padding()
                    Spacer()
                }
                .navigationBarTitle("Forage Results", displayMode: .inline)
            }
        }
    }
}

struct ForageResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ForageResultsView(results: "Sample result", image: UIImage(systemName: "leaf"))
    }
}
