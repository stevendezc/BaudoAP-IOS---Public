//
//  Base.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI
import FirebaseAuth

struct Base: View {
    @StateObject var viewModel = AuthViewModel()

    
    var body: some View {
        VStack{
            if viewModel.userSession != nil {
                TabViews()
            } else {
                Login()
            }
        }.environmentObject(viewModel)
//            .onAppear(){
//                viewModel.fetchUser()
//                if viewModel.currentUser?.id != nil {
//                    print("User Exists")
//                } else {
//                    print("user dosent exist")
//                    try! Auth.auth().signOut()
//                    print("Logged out button pressed")
//                    //        userIsLogged = false
//                    viewModel.userSession = nil
//                    viewModel.currentUser = nil
//                    viewModel.fetchUser()
//                    viewModel.currentUserName = ""
//                    viewModel.currentUserEmail = ""
//                    viewModel.currentUser = nil
//                    self.cartmanager.cartproducts = []
//                    self.cartmanager.total = 0
//                    print("user currentUser fullname is: \(String(describing: viewModel.currentUser?.name))")
//                }
//            }
    } 
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base()
    }
}
