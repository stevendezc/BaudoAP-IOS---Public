//
//  ContentViewModel.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import Foundation

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var postsAll: [Post] = []
    
    @Published var comments: [CommentModel] = []
    
    @Published var text = ""
    
    @Published var errorMessage = ""
    
    @Published var commentId = ""
    
    @Published var currentCommentId = ""
    
    @Published var userId = ""
    
    @Published var post = ""
    
    @Published var author = ""
    
    @Published var author_email = ""
    
    @Published var userCommentName = ""
    
    @Published var userCommentPic = ""
    
    //    @EnvironmentObject var viewModel: AuthViewModel
    
    //    @StateObject var viewModel = AuthViewModel()
    
    private var listenerRegistration: ListenerRegistration?
    
    //    @Published var newCommentText: String = ""
    
    init() {
        Task{ try await fetchposts() }
        
    }
    
    //    Function for Fetch posts from firebase
    @MainActor
    func fetchposts() async throws{
        
        postsAll.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("posts").order(by: "creation_date" ,descending: true)
        
        //let ImagenesContent = db.collection("Posts").whereField("Tipo", isEqualTo: "Imagen")
        
        //        print("Estos son los post de Imagenes", refImage)
        
        //        print("Firestore query started IMAGES")
        ref.getDocuments { snapshot, error in
            //            print("Firestore query started IMAGES - GOT DOCUMENT")
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                //                print("Firestore query started IMAGES - SNAPSHOT")
                for document in snapshot.documents {
                    //                    var num = 0
                    //                    print("Firestore query started IMAGES - DOCUMENTS", num)
                    //                    num += 1
                    let data = document.data()
                    let uid = document.documentID
                    
                    let id = uid
                    let thumbnail = data["thumbnail"] as? String ?? ""
                    let thumbnail2 = data["thumbnail2"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let main_media = data["main_media"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let creation_date = (data["creation_date"] as? Timestamp)?.dateValue() ?? Date()
                    
                    let post = Post(id: id, thumbnail: thumbnail,thumbnail2: thumbnail2, author: author,location: location, main_media: main_media, type: type, description: description,category: category,title: title,creation_date: creation_date)
                    self.postsAll.append(post)
                    
                    //                    print(self.postsImages)
                }
            }
        }
        
    }
    
    
    @MainActor
    func pushComment(post: String, author: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        print(userId)
        
        let db = Firestore.firestore().collection("commentaries").document()
        
        currentCommentId = db.documentID
        print("CurrentCOmmentID IS : \(currentCommentId)")
        
        self.post = post
        self.author = author
        guard let author_email = Auth.auth().currentUser?.email else {
            return
        }
        self.author_email = author_email
        
        let messageData = ["author": author ,"author_email": author_email ,"post": post,"userId": userId, "text": self.text, "timestamp": Timestamp(), "userCommentName": "" , "userCommentPic": ""] as [String : Any]
        
        //        db.setData(messageData, completion: {_ in
        //            print("CommentSaved")
        //        } )
        
        db.setData(messageData){ error in
            if let error = error{
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            } else {
                //                self.fetchNewComments()
            }
        }
        
        self.text = ""
        
        let dbPosts = Firestore.firestore()
        
        let docRef = dbPosts.collection("posts").document(post)
        
        //        docRef.setData(["Comments": FieldValue.arrayUnion([currentCommentId])], merge: true)
        //        updateData
        docRef.updateData(["commentaries": FieldValue.arrayUnion([currentCommentId])]){ error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
                //               self.fetchNewComments(postId: postId)
            }
        }
        
        
        guard let userEmail = Auth.auth().currentUser?.email else {
            return
        }
        let docRefUserCommentaries = dbPosts.collection("users").document(userEmail)
        docRefUserCommentaries.updateData(["commentaries": FieldValue.arrayUnion([currentCommentId])]){ error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
                //               self.fetchNewComments(postId: postId)
            }
        }
        
        
    }
    
    
    @MainActor
    func fetchNewComments(post uid: String) async throws{
        
        comments.removeAll()
        
        let db = Firestore.firestore().collection("commentaries")
            .whereField("post", isEqualTo: uid)
            .order(by: "timestamp" ,descending: true)
        
        listenerRegistration = db.addSnapshotListener{ querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            if let error = error {
                self.errorMessage = "Failed to listen for new comments: \(error)"
                print(error)
                return
            }
            
            if querySnapshot?.documents != nil{
                self.comments = documents.map { queryDocumentSnapshot -> CommentModel in
//                    print("Aqui ya hizo el llamado map")
                    let data = queryDocumentSnapshot.data()

                    let Id = queryDocumentSnapshot.documentID
                    let text = data["text"] as? String ?? ""
                    let author_email = data["author_email"] as? String ?? ""

                    let userId = data["userId"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let userCommentName = data["userCommentName"] as? String ?? ""
                    let userCommentPic = data["userCommentPic"] as? String ?? ""
                                        
                    return CommentModel(id: Id, author: author, author_email: author_email, post: Id, userId: userId, text: text, userCommentName: userCommentName, userCommentPic: userCommentPic)
                    
                }

                // LOOP TO INJECT USER PIC TO COMMENT
                for i in 0 ..< self.comments.count {
                    let comment = self.comments[i]
                    let ownerEmail = comment.author_email
                    // Fetch user of Comment
//                    print("Aqui llama a user por email image con el email \(ownerEmail)")
                    
                    if ownerEmail != "" {
                        self.returnUserImg(userEmailToFind: ownerEmail) { value, error in
                            var stringValue: String?
                            if let value = value {
                                // String value fetched successfully
                                stringValue = value
                                self.comments[i].userCommentPic = stringValue ?? ""
                                
                            } else if let error = error {
                                // Handle the error
                                print("Error fetching string value: \(error.localizedDescription)")
                            } else {
                                // String value not found or document does not exist
                                stringValue = "Value not found"
                            }
                        }
                        
                        self.returnUserName(userEmailToFind: ownerEmail) { valuename, error in
                            var stringValuename: String?
                            if let valuename = valuename {
                                // String value fetched successfully
//                                print("Valuename is returne from funct \(valuename)")
                                stringValuename = valuename
                                self.comments[i].userCommentName = stringValuename ?? ""
                                
                            } else if let error = error {
                                // Handle the error
                                print("Error fetching string value: \(error.localizedDescription)")
                            } else {
                                // String value not found or document does not exist
                                stringValuename = "Value not found"
                            }
                        }
                        
                        
                        
                    } else {
                        print("No hizo el llamado porque current comment_author email esta empty")
                    }
                    
                    
                }
            }else {
                print("No llame porque no hay docs")
            }
            
        }
    }
    
    func deleteItem(commentId uid: String) {
            print("Comment a eliminar ",commentId)
        
        let db = Firestore.firestore()
        let documentRef = db.collection("commentaries").document(uid)
        
        documentRef.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted.")
            }
        }
        //Delete comment id from user
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "commentaries": FieldValue.arrayRemove([uid])
            ])
        }
    }
    
    @MainActor
    func returnUserImg(userEmailToFind: String, completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userEmailToFind)
        
        docRef.getDocument { document, error in
            
            if let error = error {
                // Error occurred while fetching the document
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists {
                // Document exists, fetch the string value
                if let stringValue = document.data()?["user_pic"] as? String {
                    completion(stringValue, nil)
                } else {
                    // String value not found
                    completion(nil, nil)
                }
            } else {
                // Document does not exist
                completion(nil, nil)
            }
        }
    }
    
    
    @MainActor
    func returnUserName(userEmailToFind: String, completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userEmailToFind)
        
        docRef.getDocument { document, error in
            
            if let error = error {
                // Error occurred while fetching the document
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists {
                // Document exists, fetch the string value
                if let stringValue = document.data()?["name"] as? String {
                    completion(stringValue, nil)
                } else {
                    // String value not found
                    completion(nil, nil)
                }
            } else {
                // Document does not exist
                completion(nil, nil)
            }
        }
    }
    
    
    
    func stopListener() {
        print("sali")
        listenerRegistration?.remove()
    }
    
}



