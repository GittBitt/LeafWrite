//
//  ContentView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

// Custom ButtonStyle to change button background when pressed.
struct DarkGreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.green : Color.green.opacity(0.75))
            .cornerRadius(10)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Set the overall background to a light green color.
                Color(red: 0.9, green: 1.0, blue: 0.9)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("placeholderLeaf.png") //bug: image not showing
                        .resizable()
                        .scaledToFit()
                        .frame(height: 10) // Adjust height as needed.
                        .padding(.top, 10)
                    
                    // Placeholder title, adds title text below the image.
                    Text("LeafNote")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green.opacity(0.75))
                        .padding(10)
                    
                    Text("Journal like you're messaging yourself!")
                        .foregroundColor(Color.green.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(20)
                    
                    // Navigation Links with SF Symbols.
                    NavigationLink(destination: CalendarView()) {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Calendar")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    NavigationLink(destination: EntryView(date: Date())) {
                        HStack {
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Write Entry")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Search Entry")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    //Currently only goes to EntryView, need the button to independently be able to add photos
                    NavigationLink(destination: EntryView(date: Date())) {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Add Photo")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    NavigationLink(destination: GalleryView()) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Gallery")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
//Live camera button for debugging
//                    NavigationLink(destination: LiveCameraView()) {
//                        HStack {
//                            Image(systemName: "camera")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 24, height: 24)
//                                .foregroundColor(.white)
//                            Text("Live Camera")
//                                .foregroundColor(.white)
//                        }
//                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("LeafWrite")
                Color.green.opacity(0.75)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(JournalViewModel())
            .environmentObject(ThemeManager())
    }
}
