//
//  UserSettings.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

@MainActor
class UserSettings: ObservableObject {
    
    @Published var aporte_mensual: String = ""
    @Published var aporte_anual: String = ""
    @Published var aporte_libre: String = ""
    
    
    init() {
        Task{ try await  fetchDocument() }
    }
    
    func fetchDocument() async throws {
        let db = Firestore.firestore()
        let documentRef = db.collection("navegantes_links").document("links")
        
        
        documentRef.getDocument{ (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                
                let aporte_mensual = data?["aporte_mensual"] as? String ?? ""
                let aporte_anual = data?["aporte_anual"] as? String ?? ""
                let aporte_libre = data?["aporte_libre"] as? String ?? ""
                
                
                self.aporte_mensual = aporte_mensual
                self.aporte_anual = aporte_anual
                self.aporte_libre = aporte_libre
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
}



