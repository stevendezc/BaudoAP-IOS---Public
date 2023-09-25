//
//  LoginScreen.swift
//  FirebaseLogin
//
//  Created by Kentaro Mihara on 2023/08/08.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

import AuthenticationServices


struct LoginScreen: View {
    @StateObject var loginModel: LoginViewModel = .init()
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
                
                
                VStack(alignment: .leading){
                    
                    CustomButton(isGoogle: false)
                        .overlay{
                            SignInWithAppleButton{ (request) in
                                
                                // requesting parameters from apple login...
                                loginModel.nonce = randomNonceString()
                                request.requestedScopes = [.email, .fullName]
                            } onCompletion: {(result) in
                                
                                //getting error or success..
                                switch result{
                                case .success(let user):
                                    print("success")
                                    //do login with firebase...
                                    guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                                        print("error with firebase")
                                        return
                                    }
//                                    viewModel.userSession = Auth.auth().currentUser
                                    loginModel.appleAuthenticate(credential: credential)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }

                            }
                            .signInWithAppleButtonStyle(.white)
                            .frame(height: 55)
                            .blendMode(.overlay)
                        }
                        .clipped()
                    
                }
                .padding(.top, 40)
            }
//            .padding(.leading, 40)
            .padding(.top, 60)
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .alert(loginModel.successMessage, isPresented: $loginModel.showSuccess){
            
        }
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError){
            
        }
    }
    
    @ViewBuilder
    func CustomButton(isGoogle: Bool)->some View{
        HStack{
            Group{
                if isGoogle{
                    Image("google_logo")
                        .resizable()
                        .renderingMode(.template)

                }else{
                    Image(systemName: "applelogo")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 45)
            Text("\(isGoogle ? "Google" : "Apple") Signin")
                .font(.callout)
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 15)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
        }
        
    }
}

//#Preview {
//    LoginScreen()
//}
