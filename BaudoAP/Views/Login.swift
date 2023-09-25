//
//  Login.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//


import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

import AuthenticationServices




struct Login: View {
        @State private var email = ""
        @State private var password = ""
    //    @Binding var userIsLogged : Bool
        @State var showingAlert = false
        @State var errorAlert = ""
        @State var isSecure = true
        @State var triggerAlert = false
    
    //    @ObservedObject var viewModel = AuthViewModel()
        @EnvironmentObject var viewModel: AuthViewModel
        @Environment(\.colorScheme) var colorScheme
        @StateObject var loginModel: LoginViewModel = .init()
        @State var shouldShowObBoarding = false
        @State var showAlertVerifiedEmail = false
        let impactNotification = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        
        NavigationView{
            
                    VStack {
                        VStack(spacing: 10) {
        
                            Group{
                                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                                    Task{
                                        impactNotification.notificationOccurred(.success)
                                        let result = await viewModel.signInWithGoogle()
                                        if result == true {
                                            print("result is true")
                                            self.shouldShowObBoarding = true
                                        }
                                    }
                                }
                                .frame(width: 230)
                                
//                                CustomButton(isGoogle: false)
//                                    .overlay{
                                        SignInWithAppleButton{ (request) in
                                            
                                            // requesting parameters from apple login...
                                            impactNotification.notificationOccurred(.success)
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
                                                Task{
                                                    await viewModel.appleAuthenticate(credential: credential)
                                                }
                                                
                                            case .failure(let error):
                                                print(error.localizedDescription)
                                            }

                                        }
                                        .signInWithAppleButtonStyle(.black)
                                        .frame(width:230, height: 45)

                                
                                Image("LineacircleLinea")
                            }
        
                            Group{
                                HStack{
                                    Text("Correo")
                                        .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                        .padding(.leading,20)
                                    Spacer()
                                }
        
                                TextField("Correo", text: $email)
                                    .padding()
                                    .foregroundColor(.black)
                                    .textFieldStyle(.plain)
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(20)
                                if self.email.isEmpty && triggerAlert{
                                    Text("Porfavor ingresa un correo valido")
                                        .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .caption))
                                        .foregroundColor(.red)
                                }
        
                                HStack{
                                    Text("Contraseña")
                                        .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                        .padding(.leading,20)
                                    Spacer()
                                }
        
                                ZStack(alignment: .trailing){
                                    if isSecure {
        
                                        SecureField("Contraseña", text:$password)
                                            .padding()
                                            .background(Color.white.opacity(0.5))
                                            .cornerRadius(20)
                                        Button{
                                            impactNotification.notificationOccurred(.success)
                                            isSecure.toggle()
                                        } label:{
                                            Image(systemName: "eye.slash")
                                                .font(.system(size: 20))
                                                .foregroundColor(.black)
                                                .padding()
                                        }
        
        
                                    } else {
                                        TextField("Contraseña", text:$password)
                                            .padding()
                                            .background(Color.white.opacity(0.5))
                                            .cornerRadius(20)
                                        Button{
                                            impactNotification.notificationOccurred(.success)
                                            isSecure.toggle()
                                        } label:{
                                            Image(systemName: "eye")
                                                .font(.system(size: 20))
                                                .foregroundColor(.black)
                                                .padding()
                                        }
                                    }
                                }
                                if self.password.isEmpty && triggerAlert{
                                    Text("Porfavor ingresa una contraseña")
                                        .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .caption))
                                        .foregroundColor(.red)
                                }
                            }
        
                            Group{
                                HStack{
                                    Spacer()
                                    NavigationLink(destination:
                                                    resetPass(), label: {
                                        Text("Olvidé mi contraseña")
                                            .foregroundColor(.black)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title2))
                                    } )
                                }
        
        
                                HStack{
                                    Button{
                                        impactNotification.notificationOccurred(.success)
                                        login()
                                        triggerAlert = true
                                        
                                    }label: {
                                        Text("Acceder")
                                            .font(.custom("SofiaSans-Medium",size: 18,relativeTo: .title2))
                                            .padding(.horizontal,55)
                                            .padding(.vertical,15)
                                            .foregroundColor(.black)
                                            .background(Color("Buttons"))
                                            .clipShape(Capsule())
                                            .padding(.top)
                                    }
                                }
                            }
        
                            Group{
                                HStack{
                                    Text("¿No tienes una cuenta?")
                                        .foregroundColor(Color("Text"))
                                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title2))
                                    NavigationLink(destination: createUser(), label: {
                                        Text("Crear usuario")
                                            .foregroundColor(Color("Text"))
                                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title))
                                    }
                                    )
                                }.padding(.top,20)
                            }
        
        
                        }
                        .padding(30)
                        Image("LogoBaudo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
        
                    }
                    .alert(loginModel.successMessage, isPresented: $loginModel.showSuccess){
        
                    }
                    .alert(loginModel.errorMessage, isPresented: $loginModel.showError){
        
                    }
        
                    //FONDO DE TODO EL CONTENT VIEW
                    .background(
                        Image("Fondo")
                            .ignoresSafeArea()
                    )
        
                }//FIN NAVIGATION VIEW
//                .onTapGesture {
//                    // Dismiss the keyboard when tapping outside the text field
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }
        
                .alert("Error al iniciar sesión", isPresented: $showingAlert) {
                    // add buttons here
                } message: {
                    Text("Porfavor verifica el correo o contraseña y vuelve a intentarlo")
                }
        
                .alert("Debes verificar tu correo", isPresented: $showAlertVerifiedEmail){

                } message: {
                    Text("Revisa tu bandeja de entrada y/o spam para verificar tu correo!")
                }
        //        .navigationTitle("Inicio session")
        
                .onAppear {
                    
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil{
                            print("PRINT USER IS LOGGED FROM LOGIN ")
                            //                    userIsLogged = true
                            viewModel.userSession = Auth.auth().currentUser
                            
                            if user!.isEmailVerified {
                                print("USER IS VERIFIED \(user!.isEmailVerified)")
                                self.showAlertVerifiedEmail = false
                            } else {
                                print("USER IS NOT VERIFIED \(user!.isEmailVerified)")
                                self.showAlertVerifiedEmail = true
                            }
                        }
                    }
                }
    }// FIN BODY
    
    func login(){
    
            Auth.auth().signIn(withEmail: email, password: password){ result, error in if error != nil {
    
                print(error!.localizedDescription)
                showingAlert.toggle()
                errorAlert = error!.localizedDescription
    
            }else{
    //            userIsLogged = true
                viewModel.userSession = Auth.auth().currentUser
    //            viewModel.fetchUserSnapshotListener()
    //            UserName = email  
    //            print("Username Correo: \(UserName)")
                //            result?.user.uid ?? "NONE"
                //            contentImage.fetchpostsImages()
                //            print("Images Fetched from login")
            }
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
    
    
}// FIN STRUCT


//#Preview {
//    Login()
//}
