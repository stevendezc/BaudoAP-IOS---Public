//
//  ContentViewModelShop.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import Foundation

import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth

@MainActor
class ContentViewModelShop: ObservableObject {
    @Published var postsProducts: [Product] = []

    private var listenerRegistration: ListenerRegistration?
    
//    init() {
//
//    }
    
//    @MainActor
//    
//    func fetchpostsProducts() async throws {
//            
//            // NECESARIO ??
//            postsProducts.removeAll()
//            let dbProducts = Firestore.firestore()
//            let refProducts = dbProducts.collection("productos").order(by: "creation_date" ,descending: true)
//    //            .whereField("type", isEqualTo: "image")
//            //let ImagenesContent = db.collection("Posts").whereField("Tipo", isEqualTo: "Imagen")
//            
//            //        print("Estos son los post de Imagenes", refImage)
//            
//            //        print("Firestore query started IMAGES")
//            refProducts.getDocuments { snapshot, error in
//                //            print("Firestore query started IMAGES - GOT DOCUMENT")
//                guard error == nil else{
//                    print(error!.localizedDescription)
//                    return
//                }
//                
//                if let snapshot = snapshot {
//                    //                print("Firestore query started IMAGES - SNAPSHOT")
//                    for document in snapshot.documents {
//                        //                    var num = 0
//                        //                    print("Firestore query started IMAGES - DOCUMENTS", num)
//                        //                    num += 1
//                        let data = document.data()
//                        let uid = document.documentID
//                        
//                        let id = uid
//                        let title = data["title"] as? String ?? ""
//                        let thumbnail = data["thumbnail"] as? String ?? ""
//                        let size_final = data["size_final"] as? String ?? ""
//                        let description = data["description"] as? String ?? ""
//                        let gallery = data["gallery"] as? String ?? ""
//                        let price = data["price"] as? String ?? ""
//                        let type = data["type"] as? String ?? ""
//                        let subtype = data["subtype"] as? String ?? ""
//                        let stock = data["stock"] as? Int ?? 0
//                        let stock_cenido_xs = data["stock_cenido_xs"] as? Int ?? 0
//                        let stock_cenido_s = data["stock_cenido_s"] as? Int ?? 0
//                        let stock_cenido_m = data["stock_cenido_m"] as? Int ?? 0
//                        let stock_cenido_l = data["stock_cenido_l"] as? Int ?? 0
//                        let stock_cenido_xl = data["stock_cenido_xl"] as? Int ?? 0
//                        
//                        let stock_regular_xs = data["stock_regular_xs"] as? Int ?? 0
//                        let stock_regular_s = data["stock_regular_s"] as? Int ?? 0
//                        let stock_regular_m = data["stock_regular_m"] as? Int ?? 0
//                        let stock_regular_l = data["stock_regular_l"] as? Int ?? 0
//                        let stock_regular_xl = data["stock_regular_xl"] as? Int ?? 0
//                    
//                        
//                        let creation_date = (data["creation_date"] as? Timestamp)?.dateValue() ?? Date()
//                        
//                        let postproduct = Product(id: id, title: title, thumbnail: thumbnail, size_final: size_final, description: description, gallery: gallery, price: price,type: type, subtype: subtype, cantidad: 0, stock: stock, tallaFinal: "", creation_date: creation_date, stock_cenido_xs: stock_cenido_xs, stock_cenido_s: stock_cenido_s, stock_cenido_m: stock_cenido_m, stock_cenido_l: stock_cenido_l, stock_cenido_xl: stock_cenido_xl , stock_regular_xs: stock_regular_xs , stock_regular_s: stock_regular_s, stock_regular_m: stock_regular_m, stock_regular_l: stock_regular_l, stock_regular_xl: stock_regular_xl)
//                        self.postsProducts.append(postproduct)
//                    }
//                }
//            }
//        }
    
    
    func fetchpostsProducts2() async throws {
        
        postsProducts.removeAll()
        
        let dbProducts = Firestore.firestore()
        let refProducts = dbProducts.collection("productos")

        listenerRegistration = refProducts.addSnapshotListener{ querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            if let error = error {
                // Handle error products
                print(error)
                return
            }
            if querySnapshot?.documents != nil{
                self.postsProducts = documents.map { queryDocumentSnapshot -> Product in
                    let data = queryDocumentSnapshot.data()
                    let uid = queryDocumentSnapshot.documentID
                    
                    let id = uid
                    let title = data["title"] as? String ?? ""
                    let thumbnail = data["thumbnail"] as? String ?? ""
                    let size_final = data["size_final"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let gallery = data["gallery"] as? [String] ?? []
                    let price = data["price"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let subtype = data["subtype"] as? String ?? ""
                    let stock = data["stock"] as? Int ?? 0
                    let stock_cenido_xs = data["stock_cenido_xs"] as? Int ?? 0
                    let stock_cenido_s = data["stock_cenido_s"] as? Int ?? 0
                    let stock_cenido_m = data["stock_cenido_m"] as? Int ?? 0
                    let stock_cenido_l = data["stock_cenido_l"] as? Int ?? 0
                    let stock_cenido_xl = data["stock_cenido_xl"] as? Int ?? 0
                    
                    let stock_regular_xs = data["stock_regular_xs"] as? Int ?? 0
                    let stock_regular_s = data["stock_regular_s"] as? Int ?? 0
                    let stock_regular_m = data["stock_regular_m"] as? Int ?? 0
                    let stock_regular_l = data["stock_regular_l"] as? Int ?? 0
                    let stock_regular_xl = data["stock_regular_xl"] as? Int ?? 0

                    let creation_date = (data["creation_date"] as? Timestamp)?.dateValue() ?? Date()
                    
                    return Product(id: id, title: title, thumbnail: thumbnail, size_final: size_final, description: description, gallery: gallery, price: price,type: type, subtype: subtype, cantidad: 0, stock: stock, tallaFinal: "", creation_date: creation_date, stock_cenido_xs: stock_cenido_xs, stock_cenido_s: stock_cenido_s, stock_cenido_m: stock_cenido_m, stock_cenido_l: stock_cenido_l, stock_cenido_xl: stock_cenido_xl , stock_regular_xs: stock_regular_xs , stock_regular_s: stock_regular_s, stock_regular_m: stock_regular_m, stock_regular_l: stock_regular_l, stock_regular_xl: stock_regular_xl)
                }
                
            }
        }
        
    }
    
    
    func stopListener() {
        print("sali")
        listenerRegistration?.remove()
    }
}
