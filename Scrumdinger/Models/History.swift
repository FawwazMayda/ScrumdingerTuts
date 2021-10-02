//
//  History.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 02/10/21.
//
import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [String]
    var lengthInMinutes: Int
    var transcript: String?
    var attendeesString: String {
        attendees.joined(separator: ", ")
    }

    init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String?) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
