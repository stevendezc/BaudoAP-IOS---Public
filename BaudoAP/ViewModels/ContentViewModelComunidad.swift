//
//  ContentViewModelComunidad.swift
//  BaudoAP
//
//  Created by Codez on 26/03/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth

class ContentViewModelComunidad: ObservableObject {
    
    @Published var usersComunidad: [Users] = []
    
    @Published var comments: [CommentModel] = []
    
    @Published var text = ""
    @Published var errorMessage = ""
    
    @Published var commentId = ""
    
    @Published var currentCommentId = ""
    
    @Published var userId = ""
    
    @Published var postId = ""
    
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        Task{
            try await fetchusersComunidad()
        }
    }
    
//    Function for Fetch posts from firebase
    @MainActor
    func fetchusersComunidad() async throws{
        
        // NECESARIO ??
        usersComunidad.removeAll()
        let dbCom = Firestore.firestore()
        
        let refComunidad = dbCom.collection("communities")
        
        //let ImagenesContent = db.collection("Posts").whereField("Tipo", isEqualTo: "Imagen")
        
//        print("Estos son los post de Imagenes", refImage)
        

//        print("Firestore query started COMUNIDAD")
         refComunidad.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {

                    let data = document.data()
                    
                    let id: String = UUID().uuidString
                    let thumbnail = data["thumbnail"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
//                    let creation_date = data["creation_date"] as? Timestamp
                    let category = data["category"] as? String ?? ""
                    let number = data["number"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    
                    let email = data["email"] as? String ?? ""
                    let website = data["website"] as? String ?? ""
                    let instagram = data["instagram"] as? String ?? ""
                    let facebook = data["facebook"] as? String ?? ""
                    let whatsapp = data["whatsapp"] as? String ?? ""
                    let twitter = data["twitter"] as? String ?? ""
                    let creation_date = (data["creation_date"] as? Timestamp)?.dateValue() ?? Date()
                    
                    let postcomunidad = Users(id: id, thumbnail: thumbnail, description: description, category: category, name: name, location: location, creation_date: creation_date, instagram: instagram, facebook: facebook, twitter: twitter, whatsapp: whatsapp, number: number, email: email, website: website)
                    self.usersComunidad.append(postcomunidad)
                    
                }
            }
        }
        
    }
   
}

