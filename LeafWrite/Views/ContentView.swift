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
                Color(red: 0.9, green: 1.0, blue: 0.9)
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
//                    // Placeholder image for the title.
//                    Image("placeholderLeaf.png")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 50)
                    
                    // Title text.
                    Text("LeafWrite")
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
                    
                    //Forage camera button
                    NavigationLink(destination: ForageCameraView()) {
                        HStack {
                            Image(systemName: "camera.viewfinder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Forage")
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(DarkGreenButtonStyle())
                    
                    //Navigates to gallery
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
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("LeafWrite")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(JournalViewModel())
//            .environmentObject(ThemeManager())
    }
}
