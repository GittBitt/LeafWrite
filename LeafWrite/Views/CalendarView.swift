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
        
        Text("Select a day to write entry for!")
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding(10)
        VStack {
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            NavigationLink(destination: EntryView(date: selectedDate)) {
                HStack {
                    Image(systemName: "pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("Go to Entry")
                }
            }
        }
        .navigationTitle("Calendar")
    }
}
