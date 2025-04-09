//
//  CalendarView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            // Set the overall background to a light green color.
            Color(red: 0.9, green: 1.0, blue: 0.9)
                .ignoresSafeArea()

            VStack {
                Text("Select a day to write entry for!")
                    .font(.title2)
                    .shadow(radius: 1, x: 0, y: 1)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .background(Color.white)
                
                NavigationLink(destination: EntryView(date: selectedDate)) {
                    HStack {
                        Image(systemName: "pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Text("Go to Entry")
                            .foregroundColor(.white)
                    }
                } .buttonStyle(DarkGreenButtonStyle())
            }
            .navigationTitle("Calendar")
        }
    }
}
