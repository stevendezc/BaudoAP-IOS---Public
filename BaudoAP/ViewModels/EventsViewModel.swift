//
//  EventsViewModel.swift
//  BaudoAP
//
//  Created by Codez Studio on 10/07/23.
//

import Foundation
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
class EventsViewModel: ObservableObject{
    
    @Published var events: [Event] = []
    private var listenerRegistration: ListenerRegistration?
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    @MainActor
    func fetchEvents() async throws{
        events.removeAll()
        
        let db = Firestore.firestore().collection("events").order(by: "date" ,descending: false)
        
        listenerRegistration = db.addSnapshotListener{ querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
//                print("No documents")
                return
            }
            
            if let error = error {
                self.errorMessage = "Failed to listen for new comments: \(error)"
//                print(error)
                return
            }
            
            self.events = documents.map { queryDocumentSnapshot -> Event in
                let data = queryDocumentSnapshot.data()
                
                let Id = queryDocumentSnapshot.documentID
                
               
                let event_date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                
                let description = data["description"] as? String ?? ""
                let eventUrl = data["event_url"] as? String ?? ""
                let date_range = data["date_range"] as? String ?? ""
                let month = data["month"] as? Int ?? 0
                let subject = data["subject"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let year = data["year"] as? Int ?? 0
                
                return Event(id: Id ,event_date: event_date, date_range: date_range, description: description, eventUrl: eventUrl, month: month, subject: subject, title: title, year: year)
            }
             
        }
    }
    
    func stopListener() {
        listenerRegistration?.remove()
    }
    
}
