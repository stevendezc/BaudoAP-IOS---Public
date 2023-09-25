//
//  DBUser.swift
//  BaudoAP
//
//  Created by Codez Studio on 7/07/23.
//

import Foundation

struct DBUser: Identifiable, Codable {
    
    var id: String
    var name: String?
    var email: String?
    var user_pic: String?
    var reaction: [String]?
}

