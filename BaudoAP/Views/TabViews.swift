//
//  TabViews.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Kingfisher
import GoogleSignIn


struct TabViews: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    @State private var tabSelection = 0
    @State private var lastTapTime: Date?
    
    @State var shouldShowOnBoardingHome = false
    @State var IsUserVerified = true
    
    let impactNotification = UINotificationFeedbackGenerator()
    
//    @ObservedObject var contentImage = ContentViewModelImage()
//    @ObservedObject var contentVideo = ContentViewModelVideo()
//    @ObservedObject var contentPodcast = ContentViewModelPodcast()
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView{
            
            VStack{
                
                HStack{
                    Group{
                        NavigationLink(destination: UserView()) {
                            //                        print("DEBUG: currentUser is\(viewModel.currentUser?.fullname ?? "")")
                            
                            ZStack(alignment: .topTrailing){
                                if viewModel.currentUser != nil {
                                    if viewModel.currentUser?.user_pic == "" {
                                        Image("logoBaudoWhite")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(10)
                                            .foregroundColor(Color("Buttons"))
                                            .frame(width: 60,height: 60,alignment: .center)
                                            .clipShape(Circle())
                                            .padding(2)
                                            .cornerRadius(60)
                                            .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                                    } else {
                                        KFImage(URL(string: viewModel.currentUser?.user_pic ?? ""))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60 ,height: 60)
                                            .cornerRadius(60)
                                            .padding(2)
                                            .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                                    }
                                } else {
                                    Image("logoBaudoWhite")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(10)
                                        .foregroundColor(Color("Buttons"))
                                        .frame(width: 60,height: 60,alignment: .center)
                                        .clipShape(Circle())
                                        .padding(2)
                                        .cornerRadius(60)
                                        .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                                }
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 15,height: 15, alignment: .trailing)
                                    .foregroundColor(Color("Text"))
                            }
                        }
                    }
                    
                    
                    Group{
                        VStack(alignment: .leading){
                            Text("Hola,")
                                .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title3))
                                .multilineTextAlignment(.leading)
                            
                            if viewModel.currentUser != nil {
                                Text("\(viewModel.currentUser?.name ?? "")")
                                    .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                            } else {
                                VStack{
                                    HStack{
                                        VStack(alignment: .leading){
                                            HStack{
                                                Text(" ")
                                                Spacer()
                                            }
                                        }
                                        .frame(maxWidth: 200, maxHeight: 10)
                                        .background(Color(UIColor.lightGray).opacity(0.3))
                                        .cornerRadius(20)
                                        
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Group{
                        NavigationLink(destination: VideoNosotros() ) {
                            Image("LogoBaudoO")
                        }
                    }
                    
                }.id("Header")
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                
                
                //                .border(Color.red, width: 4)
                .overlay(Rectangle().frame(maxWidth: .infinity,maxHeight: 1, alignment: .bottom).foregroundColor(Color("AccentColor")), alignment: .bottom)
                
                Group{
                    ScrollViewReader { reader in
                        TabView{
                            Home()
                                .tabItem{
                                    Image(systemName: "house")
                                    Text("Inicio")
                                    
                                }
                            Tienda()
                                .tabItem{
                                    Image(systemName: "bag")
                                    Text("Tienda")
                                }
                            Comunidad()
                                .tabItem{
                                    Image(systemName: "person.3")
                                    Text("Comunidad")
                                }
                            Eventos()
                                .tabItem{
                                    Image(systemName: "calendar")
                                    Text("Eventos")
                                }
                            Navegantes()
                                .tabItem{
                                    Image(systemName: "sailboat")
                                    Text("Navegantes")
                                }
                        }
                        
                        
                        .gesture(
                            TapGesture(count: 2)
                                .onEnded { _ in
                                    impactNotification.notificationOccurred(.success)
                                    if let lastTapTime = lastTapTime, abs(lastTapTime.timeIntervalSinceNow) < 500.0 {
                                        // Perform the scrolling action here
                                        withAnimation(.linear(duration: 5000)){
                                            reader.scrollTo("TopToScroll", anchor: .top)
                                            reader.scrollTo("TopToScrollTienda", anchor: .top)
                                            reader.scrollTo("TopToScrollComunidad", anchor: .top)
                                            reader.scrollTo("TopToScrollEventos", anchor: .top)
                                            reader.scrollTo("TopToScrollNavegantes", anchor: .top)
                                        }
                                    }
                                    lastTapTime = Date()
                                }
                        )
                        .environmentObject(AuthViewModel())
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                    }
                }// FIN GROUP TABVIEW
            }
        }
        .fullScreenCover(isPresented: $IsUserVerified, onDismiss: nil){
            Text("por favor verifica tu correo electrónico dando click en el enlace en tu bandeja de entrada y/o spam.")
                .padding()
                .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .title2))
                .foregroundStyle(Color("Text"))
            Button{
                impactNotification.notificationOccurred(.success)
                viewModel.logout()
            } label:{
                Text("Continuar")
            }
            .padding()
            .background(Color("Yellow"))
            .foregroundStyle(.black)
            .cornerRadius(20.0)
        }
        
        .fullScreenCover(isPresented: $shouldShowOnBoardingHome, onDismiss: nil){
            OnBoarding()
        }
        
        // Verification of user is logged in or not.
        .onAppear {
            self.IsUserVerified = viewModel.UserIsNotVerified
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.shouldShowOnBoardingHome = viewModel.shouldShowOnBoarding
            }
            
            print("shouldShowOnBoardingHome \(self.shouldShowOnBoardingHome)")
            
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil{
                    viewModel.fetchUser()
                    
                    if user!.isEmailVerified {
                        print("USER IS VERIFIED \(user!.isEmailVerified)")
                        self.IsUserVerified = false
                    } else {
                        print("USER IS NOT VERIFIED \(user!.isEmailVerified)")
                        self.IsUserVerified = true
                    }
                    
                }else{
                    print("USUARIO NO ESTA LOGGEADO")
                    //userIsLogged = false
                }
            }
        }
    }
}// FIN struct TabViews


struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
            .environmentObject(AuthViewModel())
        
    }
}
