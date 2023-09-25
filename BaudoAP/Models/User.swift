//
//  User.swift
//  BaudoAP
//
//  Created by Codez Studio on 2/07/23.
//

import Foundation

struct User: Identifiable {
    var id: String?
    var name: String?
    var email: String?
    var user_pic: String?
    var reactions: [String]?
    var saved_posts: [String]?
    var commentaries: [String]?
    var listened_podcast: [String]?
    var reminders_events: [String]?
    
}

