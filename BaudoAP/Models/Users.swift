//
//  UserComunidad.swift
//  BaudoAP
//
//  Created by Codez on 26/03/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase


struct Users: Codable, Identifiable {
    var id: String?
    var thumbnail: String
    var description: String
    var category: String
    var name: String
    var location: String
    var creation_date: Date
    var instagram: String
    var facebook: String
    var twitter: String
    var whatsapp: String
    var number: String
    var email: String
    var website: String
    
    var creationDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd 'of' MMMM"
            return formatter.string(from: creation_date)
        }
}
