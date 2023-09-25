//
//  OnBoarding.swift
//  BaudoAP
//
//  Created by _Codez on 14/09/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct OnBoarding: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var currentTab = 0
    
    var body: some View {
        VStack{
            TabView(selection: $currentTab,
                    content:  {
                first()
                    .tag(0)
                second()
                    .tag(1)
                third()
                    .tag(2)
                four()
                    .tag(3)
                five()
                    .tag(4)
                six()
                    .tag(5)
                Button{
                    viewModel.fetchUser()
                    viewModel.shouldShowOnBoarding = false
                    
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil{
                            print("PRINT USER IS LOGGED FROM LOGIN ")
                            //                    userIsLogged = true
                            viewModel.userSession = Auth.auth().currentUser
                        }
                    }
                    
                    dismiss()
                }label:{
                    VStack{
                        Text("Continuar")
                            .font(.custom("SofiaSans-Black",size: 20,relativeTo: .caption))
                            .padding(30)
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color("Yellow"), lineWidth: 2))
                            .padding(3)
                            .foregroundColor(.black)
                            .background(Color("Yellow")) 
                            .cornerRadius(50)
                    }
                }
                .tag(6)
            })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Image("LogoBaudo")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }
    }
    
}

struct first: View {
    var body: some View {
        VStack{
            
            
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 1")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Perfil | Revisa tus intereses. ")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Mira el seguimiento de tus interacciones dentro de la app.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso1")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
                

            }
            .padding(50)
//            .padding(.bottom,35)
//            .padding(.top,40)
//            .padding(.horizontal,40)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
//            .padding(.vertical,10)
//            .padding(.horizontal,20)
            .padding(.horizontal)
            
        }
        
    }
}

struct second: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 2")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Explora contenidos")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Explora nuestros contenidos en las secciones de video, imagen y podcast.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso2")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
            }
            .padding(50)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            .padding(.horizontal)
            
        }
        
    }
}

struct third: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 3")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Comenta y abre el debate. ")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Puedes opinar y reaccionar en nuestros videos, imágenes y podcast.  Déjanos saber qué piensas.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso3")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
            }
            .padding(50)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            .padding(.horizontal)
            
        }
        
    }
}

struct four: View {
    var body: some View {
        VStack{
            
            
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 4")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Consulta a nuestra comunidad.")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Filtra por categorias y conecta con emprendimientos locales.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso4")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
            }
            .padding(50)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            .padding(.horizontal)
            
        }
    }
}

struct five: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 5")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Conviértete en navegante.")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Selecciona el aporte que mejor se ajuste y accede a contenidos exclusivos.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso5")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
            }
            .padding(50)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            .padding(.horizontal)
            
        }
    }
}

struct six: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                //TEXTOS
                VStack(alignment: .leading){
                    Text("Paso 6")
                        .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    Text("Conoce nuestra tienda.")
                        .font(.custom("SofiaSans-Bold",size: 23,relativeTo: .title2))
                    Text("Apóyanos adquiriendo nuestros productos.")
                        .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                }
                
                HStack{
                    Spacer()
                    Image("paso6")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    Spacer()
                }
            }
            .padding(50)
//            .padding(.bottom,35)
//            .padding(.top,40)
//            .padding(.horizontal,40)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
//            .padding(.vertical,10)
//            .padding(.horizontal,20)
            .padding(.horizontal)
        }
    }
}



struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
