//
//  DateFormatter.swift
//  LeafWrite
//
//  Created by Nghi Huynh on 4/4/25.
//

// DateFormatter+Extensions.swift
import Foundation

extension DateFormatter {
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
