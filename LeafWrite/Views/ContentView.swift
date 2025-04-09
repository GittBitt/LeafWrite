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
            GeometryReader { geometry in
                ZStack {
                    // Full-screen adaptive background.
                    Color(red: 0.9, green: 1.0, blue: 0.9)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: geometry.size.height * 0.02) {
                            // Placeholder title image.
                            Image("placeholderLeaf.png")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height * 0.15)
                                .padding(.top, geometry.size.height * 0.02)
                            
                            Text("LeafNote")
                                .font(.system(size: geometry.size.width * 0.08, weight: .bold))
                                .foregroundColor(Color.green.opacity(0.75))
                                .padding(.horizontal)
                            
                            Text("Journal like you're messaging yourself!")
                                .foregroundColor(Color.green.opacity(0.75))
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            // Buttons adapt their spacing based on screen size.
                            NavigationLink(destination: CalendarView()) {
                                HStack {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.06)
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
                                        .frame(width: geometry.size.width * 0.06)
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
                                        .frame(width: geometry.size.width * 0.06)
                                        .foregroundColor(.white)
                                    Text("Search Entry")
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(DarkGreenButtonStyle())
                            
                            NavigationLink(destination: EntryView(date: Date())) {
                                HStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.06)
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
                                        .frame(width: geometry.size.width * 0.06)
                                        .foregroundColor(.white)
                                    Text("Gallery")
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(DarkGreenButtonStyle())
                            
                            // New Forage camera button using YOLOv3.
                            NavigationLink(destination: ForageCameraView()) {
                                HStack {
                                    Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.06)
                                        .foregroundColor(.white)
                                    Text("Forage")
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(DarkGreenButtonStyle())
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            .navigationTitle("LeafWrite")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 14 Pro")
            ContentView()
                .previewDevice("iPad Pro (11-inch) (4th generation)")
        }
        .environmentObject(JournalViewModel())
        .environmentObject(ThemeManager())
    }
}
