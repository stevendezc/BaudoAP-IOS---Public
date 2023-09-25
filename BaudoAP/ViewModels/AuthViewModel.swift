//
//  AuthViewModel.swift
//  BaudoAP
//
//  Created by Codez Studio on 2/07/23.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import GoogleSignIn
import FirebaseStorage
import FirebaseCore

// For Sign in with Apple
import AuthenticationServices
import CryptoKit

@MainActor
class AuthViewModel: ObservableObject{
    
    @Published var userID: String = ""
    
    @Published var userSession: FirebaseAuth.User?
    
    @Published var currentUser: User?
    
    @Published var currentUserName: String = ""
    
    @Published var currentUserEmail: String = ""
    
    @Published var currentUSERCOMMENT: User?
    
    @Published var likedPostsNumber: Int = 0
    
    @Published var ReactionsCurrentUser: [String] = []
    
    @Published var shouldShowOnBoarding = false
    @Published var UserIsNotVerified = false
    
    @Published var newUserPic = ""
    
    @Published var countMemoria: Int = 0
    @Published var countAmbiente: Int = 0
    @Published var countGenero: Int = 0
    
    @Published var porcMemoria = 0.0
    @Published var porcAmbiente = 0.0
    @Published var porcGenero = 0.0
    
    @Published var PostsGuardados: [String] = []
    @Published var PostModelGuardados: [Post] = []
    @Published var PodcastsListenedGuardados: [String] = []
    @Published var RemindersGuardados: [String] = []
    
    @Published var impactNotification = UINotificationFeedbackGenerator()
    
    @Published var UserComments: [String] = []
    
    @Published var ganaMemoria = true
    @Published var ganaAmbiente = false
    @Published var ganaGenero = false
    @Published var ColorCategoryWinner = ""
    @Published var ColorCategorySecond = ""
    @Published var ColorCategoryThird = ""
    
    
    // APPLE LOGIN
    // MARK: Success Properties
    @Published var showSuccess: Bool = false
    @Published var successMessage: String = ""
    
    // MARK: Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    
    // MARK: App Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    @AppStorage("token") var token: String?
    
    @AppStorage("login_name") var loginName: String = ""
    
    // MARK: Apple Sign in Properties
    @Published var nonce: String = ""
    
    
    
    // MARK: Handling Error
    func handleError(error: Error) async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
    init() {
        //        fetchUser()
        userSession = Auth.auth().currentUser
    }
    
    func saved_posts(postID uid: String) {
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            //            print("Desde la function de LikePosts to go update data con UID De \(uid) y current user EMAIL \(userEmail)")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "saved_posts": FieldValue.arrayUnion([uid])
            ])
            self.fetchUser()
            //            print("Desde la function de LikePosts to go update data")
            self.PostsGuardados.append(uid)
            //            self.fetchUser()
            //            print("CURRENT REACTION FROM USER IS",currentUser?.reaction ?? [])
        }
    }
    
    func removeReaction(postId uid: String){
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "saved_posts": FieldValue.arrayRemove([uid])
            ])
            if let index = PostsGuardados.firstIndex(of: uid) {
                PostsGuardados.remove(at: index) // array is now ["world"]
            }
            self.fetchUser()
            //            print("CURRENTUSER REACTION FROM DISLIKES FUNCTION IS",currentUser?.reactions ?? [])
        }
    }
    
    
    func GetReactionPorcentajes() {
        print("Bienvenidos Gente del getReactionsporcentaje func")
        
        self.countMemoria = 0
        self.countAmbiente = 0
        self.countGenero = 0
        
        self.porcMemoria = 0
        self.porcAmbiente = 0
        self.porcGenero = 0
        
        if self.ReactionsCurrentUser.count > 0 {
            for i in 0 ..< self.ReactionsCurrentUser.count {
                if i == 1 {
                    print("soy el mejor")
                }
                let post = self.ReactionsCurrentUser[i]
                
                self.getPostCategory(PostId: post) { [self] valuecat, error in
                    if let valuecat = valuecat {
                        if valuecat == "memoria"{
                            self.countMemoria += 1
                        }
                        if valuecat == "medio_ambiente"{
                            self.countAmbiente += 1
                        }
                        if valuecat == "genero"{
                            self.countGenero += 1
                        }
                        
                    } else if let error = error {
                        // Handle the error
                        print("Error fetching string value: \(error.localizedDescription)")
                    } else {
                        // String value not found or document does not exist
                        print("Value not found")
                    }
                    let totalPorcentaje = self.ReactionsCurrentUser.count
                    self.porcMemoria = Double(self.countMemoria * 100) / Double(totalPorcentaje)
                    print("PorcMemoria",self.porcMemoria)
                    self.porcAmbiente = Double(self.countAmbiente * 100) / Double(totalPorcentaje)
                    print("PorcAmbiente",self.porcAmbiente)
                    self.porcGenero = Double(self.countGenero * 100) / Double(totalPorcentaje)
                    print("PorcGenero",self.porcGenero)
                    //                    print("Hasta Luego Gente del getReactionsporcentaje func")
                    
                    self.ganaGenero = false
                    self.ganaMemoria = false
                    self.ganaAmbiente = false
                    
                    
                    if self.porcMemoria >= self.porcAmbiente && self.porcMemoria >= self.porcGenero {
                        self.ganaMemoria = true
                        self.ganaAmbiente = false
                        self.ganaGenero = false
                        self.ColorCategoryWinner = "Memoria"
                        self.ColorCategorySecond = "Ambiente"
                        self.ColorCategoryThird = "Genero"
                        print("GANO MEMORIA DESDE VIEWMODEL \(self.porcMemoria)")
                    }
                    if self.porcAmbiente >= self.porcGenero && self.porcAmbiente > self.porcMemoria {
                        self.ganaAmbiente = true
                        self.ganaMemoria = false
                        self.ganaGenero = false
                        self.ColorCategoryWinner = "Ambiente"
                        self.ColorCategorySecond = "Memoria"
                        self.ColorCategoryThird = "Genero"
                        print("GANO AMBIENTE DESDE VIEWMODEL \(self.porcAmbiente) ")
                    }
                    if self.porcGenero > self.porcMemoria && self.porcGenero > self.porcAmbiente{
                        self.ganaGenero = true
                        self.ganaAmbiente = false
                        self.ganaMemoria = false
                        self.ColorCategoryWinner = "Genero"
                        self.ColorCategorySecond = "Ambiente"
                        self.ColorCategoryThird = "Memoria"
                        print("GANO GENERO DESDE VIEWMODEL\(self.porcGenero) ")
                    }
                }
                
            }
            //            print("This runs only one time💙")
            //            self.whoWins()
        }
    }
    
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Failed to fetch current user info")
            return
        }
        
        self.UserComments = []
        let userEmail: String = (Auth.auth().currentUser?.email ?? "")
        
        Firestore.firestore().collection("users").document(userEmail).getDocument{ snapshot, error in
            if let error = error {
                print("Failed to fetch current user info,\(error)")
                return
            }
            
            guard let data = snapshot?.data() else { return }
            
            //            print("DATA INSIDE IS \(data)")
            print("Hizo Llamado al firebase para FetchUser - AuthViewModel 💙")
            let id = uid
            let email = data["email"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let user_pic = data["user_pic"] as? String ?? ""
            let reactions = data["reactions"] as? [String] ?? []
            let saved_posts = data["saved_posts"] as? [String] ?? []
            let commentaries = data["commentaries"] as? [String] ?? []
            let listened_podcast = data["listened_podcast"] as? [String] ?? []
            let reminders_events = data["reminders_events"] as? [String] ?? []
            
            self.currentUser = User(id: id, name: name, email: email, user_pic: user_pic, reactions: reactions, saved_posts: saved_posts, commentaries: commentaries, listened_podcast: listened_podcast, reminders_events: reminders_events)
            //print("currentUser is:  \(self.currentUser)")
            
            self.currentUserName = self.currentUser?.name ?? ""
            self.currentUserEmail = self.currentUser?.email ?? ""
            self.ReactionsCurrentUser = self.currentUser?.reactions ?? []
            self.PostsGuardados = self.currentUser?.saved_posts ?? []
            self.UserComments = self.currentUser?.commentaries ?? []
            self.PodcastsListenedGuardados = self.currentUser?.listened_podcast ?? []
            self.RemindersGuardados  = self.currentUser?.reminders_events ?? []
            print("REMINDERS GUARDADOS \(self.RemindersGuardados)")
            
            //            print("podcastListenedguardadosArray \(self.PodcastsListenedGuardados)")
            
            //            print("USERCOMMENTS ABAJO\(self.UserComments)")
            
            //            print("Reactions from fetchuser first \(self.ReactionsCurrentUser)")
            
            self.GetReactionPorcentajes()
        }
        
    }
    
    func fetchUserbyEmail(userEmailToFind: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userEmailToFind).getDocument()
        
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        
        let Id = snapshot.documentID
        let email = data["email"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let user_pic = data["user_pic"] as? String ?? ""
        let reaction = data["reaction"] as? [String] ?? []
        
        let FinalUser = DBUser(id: Id, name: name, email: email, user_pic: user_pic, reaction: reaction)
        //        print("FINAL USER Variable ",FinalUser)
        //
        return FinalUser
    }
    
    func pushReactionToUser(postId: String?) {
        
        let db = Firestore.firestore().collection("users").document(self.currentUserEmail)
        
        let curpostId = postId
        
        let messageData = ["post": curpostId ?? "", "timestamp": Date(), "type": "likes" ] as [String : Any]
        
        db.updateData(["reactions": FieldValue.arrayUnion([messageData])]){ error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
                //               self.fetchNewComments(postId: postId)
            }
        }
    }
    
    
    func likePost(postId uid: String){
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            //            print("Desde la function de LikePosts to go update data con UID De \(uid) y current user EMAIL \(userEmail)")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "reactions": FieldValue.arrayUnion([uid])
            ])
            self.fetchUser()
            //            print("Desde la function de LikePosts to go update data")
            self.ReactionsCurrentUser.append(uid)
            //            self.fetchUser()
            //            print("CURRENT REACTION FROM USER IS",currentUser?.reaction ?? [])
        }
    }
    
    func dislikePost(postId uid: String){
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "reactions": FieldValue.arrayRemove([uid])
            ])
            if let index = ReactionsCurrentUser.firstIndex(of: uid) {
                ReactionsCurrentUser.remove(at: index) // array is now ["world"]
            }
            self.fetchUser()
            //            self.fetchUser()
            //            print("CURRENTUSER REACTION FROM DISLIKES FUNCTION IS",currentUser?.reaction ?? [])
        }
    }
    
    enum AuthenticationError: Error {
        case tokenError(message:String)
    }
    
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app ()?.options.clientID else {
            fatalError ("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration (clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            //            print("There is no root view controller")
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            
            let googleEmailUser = user.profile?.email
            let googleNameUser = user.profile?.name
            let googleImageUser = user.profile?.imageURL(withDimension: 200)?.absoluteString
            //print("USER GOOGLE HERE ALL OBJECT: Email, Name",googleNameUser, googleEmailUser, googleImageUser)
            
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential (withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let _ = try await Auth.auth().signIn(with: credential)
            
            // Calls Api to get user logged in status
            let snapshot = try await Firestore.firestore().collection("users").document(googleEmailUser ?? "").getDocument()
            
            if snapshot.data() == nil {
                
                self.shouldShowOnBoarding = true
                
                let db = Firestore.firestore()
                let ref = db.collection("users").document(googleEmailUser ?? "")
                ref.setData(["name": googleNameUser ?? "","user_pic": googleImageUser ?? "","email": googleEmailUser ?? ""]) { err in
                    if let err = err {
                        print("ERROR: \(err)")
                        return
                    } else {
                        Task{
                            await self.sendEmailToUser(to: googleEmailUser ?? "",message: "¡Gracias por sumarte a este río de historias!"  , html:"""
                            <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img><br>
                            <div>
                            <h2> Hola, \(googleNameUser ?? self.currentUserEmail)</h2><br><br>
                                En Baudó APP encontrarás contenido exclusivo, eventos destacados, emprendimientos comunitarios e información de primera mano de todas las regiones del país con voces auténticas de cada comunidad.<br><br>
                                Un abrazo,
                                El equipo de Comunicaciones de Baudó Agencia Pública
                            </div>
                            """)
                        }
                        
                        self.fetchUser()
                    }
                }
            } else {
            }
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: Apple Sign in API
    func appleAuthenticate(credential: ASAuthorizationAppleIDCredential) async{
        // getting token...
        print("ENTERED APPLE LOGIN")
        guard let token = credential.identityToken else{
            print("error with firebase")
            return
        }
        
        // Token String
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        do{
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            
            print("FIREBASE CREDENTIALS",firebaseCredential)
            
            let result = try await Auth.auth().signIn(with: firebaseCredential)
            
            guard let email = result.user.email else{
                print("email not found with apple auth")
                return
            }
            
            var name = email
                .replacingOccurrences(of: "@gmail.com", with: "")
                .replacingOccurrences(of: "@icloud.com", with: "")
                .replacingOccurrences(of: "@hotmail.com", with: "")
                .replacingOccurrences(of: "@gmail.com", with: "")
                .replacingOccurrences(of: "@outlook.com", with: "")
                .replacingOccurrences(of: "@yahoo.com", with: "")
            
            if let display_name = result.user.displayName{
                self.loginName = display_name
                print("SelfNameinside \(self.loginName)")
            }
            else{
                self.loginName = name
                print("SelfNameOutside\(self.loginName)")
            }
            
            print(self.loginName)
            print(email)
            //            print(uid)
            self.currentUserEmail = email
            self.currentUserName = self.loginName
            
            // Calls Api to get user logged in status
            let snapshot = try await Firestore.firestore().collection("users").document(currentUserEmail).getDocument()
            
            if snapshot.data() == nil {
                print("DATA EMAIL IS EMPTY now creates user in database")
                let db = Firestore.firestore()
                let ref = db.collection("users").document(self.currentUserEmail)
                ref.setData(["name": currentUserName ,"user_pic": "" ,"email": currentUserEmail ]) { err in
                    if let err = err {
                        print("ERROR: \(err)")
                        //                    self.errorMessage = "Failed to create user document\(err)"
                        
                    } else {
                        
                        Task{
                            await self.sendEmailToUser(to: self.currentUserEmail,message: "¡Gracias por sumarte a este río de historias!"  , html:"""
                            <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img><br>
                            <div>
                            <h2> Hola, \(self.currentUserName)</h2><br><br>
                                En Baudó APP encontrarás contenido exclusivo, eventos destacados, emprendimientos comunitarios e información de primera mano de todas las regiones del país con voces auténticas de cada comunidad.<br><br>
                                Un abrazo,
                                El equipo de Comunicaciones de Baudó Agencia Pública
                            </div>
                            """)
                        }
                        
                        self.fetchUser()
                        self.shouldShowOnBoarding = true
                    }
                }
            } else {
                print("SI ENCONTRE ALGO EN SNAPSHOT")
            }
        }
        catch {
            print("ERROR")
        }
    }
    
    
    func updateUserName(newName: String) async throws {
        do{
            let db = Firestore.firestore().collection("users").document(self.currentUserEmail)
            try await db.updateData(["name": newName])
            self.fetchUser()
        } catch {
            print("Error")
        }
    }
    
    func updateUserPic(image: String) async throws {
        do{
            let db = Firestore.firestore().collection("users").document(self.currentUserEmail)
            try await db.updateData(["user_pic": image])
            
            self.fetchUser()
        } catch {
            print("Error")
        }
    }
    
    func uploadImageToStorage(image: UIImage, completion: @escaping (String?) -> Void) {
        let storage = Storage.storage()
        //         let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.001) else {
            completion(nil)
            return
        }
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("/UserImages/\(uid).jpg")
        
        let _ = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard error == nil else {
                //                print("Error uploading image: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    //                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    @MainActor
    func getPostCategory(PostId: String, completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("posts").document(PostId)
        
        docRef.getDocument { document, error in
            
            if let error = error {
                // Error occurred while fetching the document
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists {
                // Document exists, fetch the string value
                if let stringValue = document.data()?["category"] as? String {
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
    
    func playedUserPodcast(PostId: String){
        print("User played podcast complete from viewMODEL\(PostId)")
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            //            print("Desde la function de LikePosts to go update data con UID De \(uid) y current user EMAIL \(userEmail)")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "listened_podcast": FieldValue.arrayUnion([PostId])
            ])
            self.fetchUser()
        }
    }
    
    func setReminderUser(PostId: String){
        print("Set reminder user \(PostId)")
        Task{
            let userEmail: String = (Auth.auth().currentUser?.email ?? "")
            //            print("Desde la function de LikePosts to go update data con UID De \(uid) y current user EMAIL \(userEmail)")
            Firestore.firestore().collection("users").document(userEmail).updateData([
                "reminders_events": FieldValue.arrayUnion([PostId])
            ])
            self.fetchUser()
        }
    }
    
    func sendEmailToUser(to: String, message: String, html: String) async{
        print("SEND EMAIL TO USER HERE")
        let userEmail: String = "\(to)"
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestampString = dateFormatter.string(from: currentDate)
        
        let finalUser = userEmail + "-" + timestampString
        
        do{
            Firestore.firestore().collection("mail").document(finalUser).setData([
                "to": ["\(userEmail)"],
                "message": [
                    "subject" : message,
                    //                "text": "TEXT",
                    "html": html
                ]
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        catch{
            print("Error")
        }
    }
    
    func deleteUserInfo() {
        let userEmail = Auth.auth().currentUser?.email
        
        print("CurrentuserEmail is to delete = \(userEmail ?? "")")
        
        print("GOING TO CALL DELETE CURRENT USER")
        
        Auth.auth().currentUser!.delete { error in
            if let error = error {
                print("error deleting user - \(error)")
            } else {
                print("Account deleted")
            }
        }
        Task{
            await deleteUserCollection()
        }
        
    }
    
    func deleteUserCollection() async{
        let userEmail = Auth.auth().currentUser?.email
        //try await Auth.auth().currentUser?.delete()
        do{
            print("CALLED DELETE CURRENT USER NOW DELETE USER FROM COLLECTION")
            try await Firestore.firestore().collection("users").document(userEmail ?? "").delete()
            print("USER DELETED FROM COLECCION CALL SIGN OUT ")
            try! Auth.auth().signOut()
            print("USUSER SESSION = NIL")
            self.userSession = nil
        }
        catch{
            print("error deleting userColection")
        }
    }
    
    func logout(){
        try! Auth.auth().signOut()
        print("Logged out button pressed")
        //        userIsLogged = false
        self.userSession = nil
        self.currentUser = nil
        self.fetchUser()
        self.currentUserName = ""
        self.currentUserEmail = ""
        self.currentUser = nil
       
        print("user currentUser fullname is: \(String(describing: currentUser?.name))")
    }
}


















