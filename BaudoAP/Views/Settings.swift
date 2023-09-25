//
//  Settings.swift
//  BaudoAP
//
//  Created by Codez on 1/04/23.
//

import SwiftUI
import FirebaseAuth
import MessageUI



struct Settings: View {
    
    @AppStorage("isDarkMode") var isDarkMode = true
    @Environment(\.colorScheme) var colorScheme
    //@Binding var userIsLogged : Bool
    
    @State private var showWebView = false
    @State private var AlertPresent = false
    
    //@ObservedObject var viewModel = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cartmanager: CartManager
    
    let impactNotification = UINotificationFeedbackGenerator()
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Ajustes")
                        .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                    }
                    NavigationLink(destination: VideoNosotros(), label: {
                        HStack(spacing: 20){
                            Image("logoBaudoWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                            Text("¿Qué es Baudó?")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                            Spacer()
                        }
                        .padding(20)
                        .background(Color("BackgroundCards"))
                        .cornerRadius(17)
                        .foregroundColor(Color("YellowBlack"))
                    })
                    
                    Button {
                        impactNotification.notificationOccurred(.success)
                        EmailController.shared.sendEmail(subject: "Mensaje desde BaudoAP", body: "Escribe tu mensaje aqui", to: "Baudoagenciap@gmail.com")
                    } label: {
                        HStack(spacing: 20){
                            Image(systemName: "envelope")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:25)
                                .foregroundColor(Color("WhiteBlack"))
                            Text("Contacto")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                            Spacer()
                        }
                        .padding(20)
                        .background(Color("BackgroundCards"))
                        .cornerRadius(17)
                        .foregroundColor(Color("YellowBlack"))
                    }
                    
                    
                    NavigationLink(destination: PreguntasFrecuentes(), label: {
                        HStack(spacing: 20){
                            Image(systemName: "questionmark.app")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("WhiteBlack"))
                            Text("Preguntas frecuentes")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                            Spacer()
                        }
                        .padding(20)
                        .background(Color("BackgroundCards"))
                        .cornerRadius(17)
                        .foregroundColor(Color("YellowBlack"))
                    })
                    
                    
                    HStack(spacing: 20){
                        
                        Button{
                            impactNotification.notificationOccurred(.success)
                            showWebView = true
                        }label: {
                            Image(systemName: "filemenu.and.cursorarrow.rtl")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("WhiteBlack"))
                            
                            Text("Pagina web")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                                .padding(.leading,12)
                            Spacer()
                        }
                        .sheet(isPresented: $showWebView, onDismiss: {
                            
                            
                            
                        }){
                            SafariWebView(url: "https://baudoap.com")
                        }
                        
                    }
                    .padding(20)
                    .background(Color("BackgroundCards"))
                    .cornerRadius(17)
                    .foregroundColor(Color("YellowBlack"))
                    
                    NavigationLink(destination: AcuerdoConfidencialidad(), label: {
                        HStack(spacing: 20){
                            Image(systemName: "lock.doc")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("WhiteBlack"))
                            Text("Acuerdo de confidencialidad")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                            Spacer()
                        }
                        .padding(20)
                        .background(Color("BackgroundCards"))
                        .cornerRadius(17)
                        .foregroundColor(Color("YellowBlack"))
                    })
                    
                    
                    HStack(spacing: 20){
                        Button {
                            impactNotification.notificationOccurred(.success)
                            logout()
                        }label: {
                            Image(systemName: "x.square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("WhiteBlack"))
                            Text("Cerrar sesión")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                                .padding(.leading,10)
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                    .background(Color("BackgroundCards"))
                    .cornerRadius(17)
                    .foregroundColor(Color("YellowBlack"))
                    
                    HStack(spacing: 20){
                        
                        Menu{
                            Button("Estoy seguro de que quiero eliminar mi cuenta.") {
                                impactNotification.notificationOccurred(.success)
                                    deleteUser()
                            }
                        } label:{
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color("WhiteBlack"))
                            Text("Eliminar usuario")
                                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                                .padding(.leading,10)
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                    .background(Color("BackgroundCards"))
                    .cornerRadius(17)
                    .foregroundColor(Color("YellowBlack"))
                    
                    
                    HStack{
                        Picker("Mode", selection: $isDarkMode) {
                            Text("Dark")
                                .tag(true)
                            Text("Light")
                                .tag(false)
                            
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                    .padding(20)
                    .background(Color("BackgroundCards"))
                    .cornerRadius(17)
                    .foregroundColor(Color("YellowBlack"))
                    
                    
                    Spacer()
                }.padding(20)
                
                Image("LogoBaudo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                
            }
        }
        .environmentObject(cartmanager)
        .environmentObject(viewModel)
        .alert("Resultado de tu compra", isPresented: $AlertPresent) {
            // add buttons here
        } message: {
            Text("Tu compra ha sido realizada satisfactoriamente. recibiras un correo de confirmacion.")
        }
    }
    
    func logout(){
        try! Auth.auth().signOut()
        print("Logged out button pressed")
        //        userIsLogged = false
        viewModel.userSession = nil
        viewModel.currentUser = nil
        viewModel.fetchUser()
        viewModel.currentUserName = ""
        viewModel.currentUserEmail = ""
        viewModel.currentUser = nil
        self.cartmanager.cartproducts = []
        self.cartmanager.total = 0
        self.cartmanager.numberOfProducts = 0
        print("user currentUser fullname is: \(String(describing: viewModel.currentUser?.name))")
    }
    
    
    func deleteUser() {
        
        Task{
            try await viewModel.deleteUserInfo()
        }
        print("Function called ")
        viewModel.currentUserName = ""
        viewModel.currentUserEmail = ""
        self.cartmanager.cartproducts = []
        self.cartmanager.total = 0
        self.cartmanager.numberOfProducts = 0
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .preferredColorScheme(.dark)
    }
}
