//
//  Event.swift
//  BaudoAP
//
//  Created by Codez Studio on 10/07/23.
//

import SwiftUI

struct Event: Identifiable,Codable {
    var id: String?
    var event_date: Date
    var date_range: String
    var description: String
    var eventUrl: String
    var month: Int
    var subject: String
    var title: String
    var year: Int
   
    var creationDateString: String {
            let formatter = DateFormatter()
//            formatter.dateFormat = "EEEE dd '/' MMMM"
            formatter.dateFormat = "dd 'de' MMMM"
            return formatter.string(from: event_date)
        }
}



