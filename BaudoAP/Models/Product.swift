//
//  Post.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//


import SwiftUI
import FirebaseFirestoreSwift

struct Product: Identifiable,Codable, Hashable {
    var id: String?
    var title: String
    var thumbnail: String
    var size_final: String
    var description: String
    var gallery: [String]?
    var price: String
    var type: String
    var subtype: String
    var cantidad: Int
    var stock: Int
    var tallaFinal: String
    var creation_date: Date
    var stock_cenido_xs: Int
    var stock_cenido_s: Int
    var stock_cenido_m: Int
    var stock_cenido_l: Int
    var stock_cenido_xl: Int
    
    var stock_regular_xs: Int
    var stock_regular_s: Int
    var stock_regular_m: Int
    var stock_regular_l: Int
    var stock_regular_xl: Int
    
    var creationDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd 'of' MMMM"
            return formatter.string(from: creation_date)
        }
}
