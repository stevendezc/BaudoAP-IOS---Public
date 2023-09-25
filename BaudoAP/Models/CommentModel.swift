//
//  CommentModel.swift
//  BaudoAP
//
//  Created by Codez on 31/03/23.
//

import Foundation
import Firebase

struct CommentModel: Identifiable, Codable {
    var id: String
//    var profile: String
    
    var author: String
    var author_email: String
    var post: String
    var userId: String
//    var username: String
//    var date: Double
    var text: String
//    var ownerId: String
    var timestamp:  Timestamp?
    
    var userCommentName: String
    var userCommentPic: String
}
