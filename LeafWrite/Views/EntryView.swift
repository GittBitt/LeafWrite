//
//  EntryView.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

import Foundation
import SwiftUI

struct EntryView: View {
    let date: Date
    @State private var newMessage: String = ""
    @EnvironmentObject var journalVM: JournalViewModel
    
    var body: some View {
        VStack {
            List(journalVM.entries(for: date), id: \.id) { entry in
                HStack {
                    if let image = entry.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text(entry.text)
                }
            }
            HStack {
                TextField("Enter message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    journalVM.addEntry(for: date, text: newMessage)
                    newMessage = ""
                }) {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
            .navigationTitle("Entry - \(date, formatter: DateFormatter.mediumStyle)")
            .navigationBarItems(trailing:
                NavigationLink(destination: ImagePickerView(date: date)) {
                    Image(systemName: "photo")
                }
            )
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(date: Date())
            .environmentObject(JournalViewModel())
    }
}

extension DateFormatter {
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
