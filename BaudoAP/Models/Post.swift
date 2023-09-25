//
//  Post.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//


import SwiftUI

struct Post: Identifiable,Codable {
    var id: String?
    var thumbnail: String
    var thumbnail2: String
    var author: String
    var location: String
    var main_media: String
    var type:String
    var description: String
    var category: String
    var title: String
    var creation_date: Date
    
    var creationDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd 'of' MMMM"
            return formatter.string(from: creation_date)
        }
}
