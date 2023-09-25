//  User.swift
//  BaudoAP
//  Created by Codez on 24/03/23.

import SwiftUI
import Firebase
import AVKit
import Kingfisher

struct UserView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showEditProfile = false
    
    @State private var lastPost: Post?
    
    @State private var isPresentedInfoU = false
    
    @State private var trimAmountBigCircle: CGFloat = 0
    @State private var trimAmountSmallFirstCircle: CGFloat = 0
    @State private var trimAmountSmallSecondCircle: CGFloat = 0

    @ObservedObject var contentviewmodel = ContentViewModel()
    @EnvironmentObject var viewModel: AuthViewModel

    
    let Columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
    ]
    
    let animation = Animation
        .easeInOut(duration: 4)
    //            .repeatForever(autoreverses: false)
        .delay(0.5)
    
    var body: some View{
        
        ScrollView{
            Group{
                HStack{
                    ZStack (alignment: .topTrailing){
                        if let user = viewModel.currentUser {
                            
                            if viewModel.currentUser?.user_pic == ""{
                                Image("logoBaudoWhite")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                                    .foregroundColor(Color("Buttons"))
                                    .frame(width: 100,height:100,alignment: .center)
                                    .clipShape(Circle())
                                    .padding(2)
                                    .cornerRadius(100)
                                    .overlay(RoundedRectangle(cornerRadius: 100) .stroke(Color("Buttons"), lineWidth: 1))
                                
                            } else {
                                KFImage( URL(string: user.user_pic ?? ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100 ,height: 100)
                                    .cornerRadius(100)
                                    .padding(3)
                                    .overlay(RoundedRectangle(cornerRadius: 100) .stroke(Color("Buttons"), lineWidth: 1))
                                //                        .placeholder{ ProgressView() }
                                
                            }
                            
                        } else {
                            Image("logoBaudoWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(15)
                                .foregroundColor(Color("Buttons"))
                                .frame(width: 100,height: 100,alignment: .center)
                                .clipShape(Circle())
                                .padding(10)
                                .cornerRadius(100)
                                .overlay(RoundedRectangle(cornerRadius: 100) .stroke(Color("Buttons"), lineWidth: 1))
                        }
                        
                        Button{
                            showEditProfile = true
                        } label: {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 30,height: 30, alignment: .trailing)
                                .foregroundColor(Color("Text"))
                        }
                    }
                    VStack(alignment: .leading){
                        
                        Text("\(viewModel.currentUser?.name ?? "")")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title3))
                            .multilineTextAlignment(.leading)
                        
                        Text("\(viewModel.currentUser?.email ?? "")")
                            .font(.custom("SofiaSans-Light",size: 14,relativeTo: .title3))
                            .multilineTextAlignment(.leading)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing,20)
                    
                    
                    VStack(alignment: .leading,spacing: 20){
                        NavigationLink(destination: Settings()) {
                            
                            
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 25,height: 25, alignment: .trailing)
                        }
                        
                        Button{
                            isPresentedInfoU = true
                        } label:{
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25,height: 25, alignment: .trailing)
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("Buttons")), alignment: .bottom)
            }
            
            HStack{
                Text("Lo que te interesa")
                    .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                Spacer()
            }.padding()
            
                HStack(spacing:10){
                    // CIRCLE BIG
                    Group{
                        VStack(alignment: .center){
                            
                            ZStack{
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.1),lineWidth: 30)
//                                    Circle()
//                                        .trim(from: 0, to:  100)
//                                        .stroke(
//                                            Color.gray.opacity(0.3),style: StrokeStyle(lineWidth: 15,lineCap: .round)
//                                        )
                                    if viewModel.ganaMemoria{
                                        Circle()
                                            .stroke(viewModel.ganaMemoria ? Color("Memoria").opacity(0.2) : Color.gray.opacity(0.3),lineWidth: 30)
                                        Circle()
                                            .trim(from: 0, to: self.trimAmountBigCircle)
                                            .stroke(
                                                Color("Memoria").opacity(0.8),style: StrokeStyle(lineWidth: 30,lineCap: .round)
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    if viewModel.ganaAmbiente{
                                        Circle()
                                            .stroke(viewModel.ganaAmbiente ? Color("Ambiente").opacity(0.2) : Color.gray.opacity(0.3),lineWidth: 30)
                                        Circle()
                                            .trim(from: 0, to: self.trimAmountBigCircle)
                                            .stroke(
                                                Color("Ambiente").opacity(1),style: StrokeStyle(lineWidth:30,lineCap: .round)
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    if viewModel.ganaGenero{
                                        Circle()
                                            .stroke(viewModel.ganaGenero ? Color("Genero").opacity(0.2) : Color.gray.opacity(0.3),lineWidth: 30)
                                        Circle()
                                            .trim(from: 0, to: self.trimAmountBigCircle)
                                            .stroke(
                                                Color("Genero").opacity(1),style: StrokeStyle(lineWidth: 30,lineCap: .round)
                                            )
                                            .rotationEffect(.degrees(-90))

                                    }
                                }
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        
                                        withAnimation(.easeInOut(duration: 3.0)) {
                                            if viewModel.ganaMemoria {
                                                self.trimAmountBigCircle = viewModel.porcMemoria / 100
                                                
                                                print("GANO MEMORIA")
                                            }
                                            if viewModel.ganaAmbiente {
                                                self.trimAmountBigCircle = viewModel.porcAmbiente / 100
                                                
                                                print("GANO AMBIENTE")
                                            }
                                            if viewModel.ganaGenero {
                                                self.trimAmountBigCircle = viewModel.porcGenero / 100
                                                print("GANO GENERO")
                                            }
                                        }
                                    }
                                })
                                .frame(maxWidth: .infinity)
                                .padding(30)
                                .overlay(RoundedRectangle(cornerRadius: 300).stroke(Color(viewModel.ColorCategoryWinner), lineWidth: 2))
                                VStack{
                                    if viewModel.ganaMemoria {
                                        Image(systemName: "books.vertical")
                                            .font(.system(size:50))
                                        let formatedMemoria = String(format: "%.2f", viewModel.porcMemoria)
                                        Text("\(formatedMemoria)%")
                                            .foregroundColor(Color("Memoria"))
                                            .fontWeight(.bold)
                                            .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                                    }
                                    if viewModel.ganaAmbiente{
                                        Image(systemName: "leaf")
                                            .font(.system(size:50))
                                        let formatedAmbiente = String(format: "%.2f", viewModel.porcAmbiente)
                                        Text("\(formatedAmbiente)%")
                                            .foregroundColor(Color("Ambiente"))
                                            .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                                        
                                    }
                                    if viewModel.ganaGenero{
                                        Image(systemName: "flag")
                                            .font(.system(size:50))
                                        let formatedGenero = String(format: "%.2f", viewModel.porcGenero)
                                        Text("\(formatedGenero)%")
                                            .foregroundColor(Color("Genero"))
                                            .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                                    }
                                }
                            }
                            if viewModel.ganaMemoria {
                                Text("Memoria, paz y conflicto")
                                    .foregroundColor(Color("Memoria"))
                                    .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title3))
                            }
                            
                            if viewModel.ganaAmbiente{
                                Text("Medio Ambiente")
                                    .foregroundColor(Color("Ambiente"))
                                    .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title3))
                            }
                            
                            if viewModel.ganaGenero{
                                Text("Género e inclusión")
                                    .foregroundColor(Color("Genero"))
                                    .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title3))
                            }
                        }
                    }
                    
                    //SMALL CIRCLES First
                    VStack(spacing:20){
                        
                        VStack{
                            ZStack{
                                ZStack {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.1),lineWidth: 10)
                                    if viewModel.ganaMemoria || viewModel.ganaGenero{
                                        Circle()
                                            .stroke(
                                                Color("Ambiente").opacity(0.3),
                                                lineWidth: 10
                                            )
                                        Circle()
                                            .trim(from: 0, to: trimAmountSmallFirstCircle)
                                            .stroke(
                                                Color("Ambiente").opacity(1),
                                                style: StrokeStyle(
                                                    lineWidth: 10,
                                                    lineCap: .round
                                                )
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    if viewModel.ganaAmbiente{
                                        Circle()
                                            .stroke(
                                                Color("Memoria").opacity(0.3),
                                                lineWidth: 10
                                            )
                                        Circle()
                                            .trim(from: 0, to: trimAmountSmallFirstCircle)
                                            .stroke(
                                                Color("Memoria").opacity(1),
                                                style: StrokeStyle(
                                                    lineWidth: 10,
                                                    lineCap: .round
                                                )
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                        
                                }
                                .frame(width: 90,height: 90)
                                .padding(15)
                                .overlay(RoundedRectangle(cornerRadius: 300).stroke(Color(viewModel.ColorCategorySecond), lineWidth: 1))
                                VStack{
                                    
                                    
                                    if viewModel.ganaMemoria || viewModel.ganaGenero{
                                        
                                        Image(systemName: "leaf")
                                            .font(.system(size:20))
                                        let formatedAmbiente = String(format: "%.2f", viewModel.porcAmbiente)
                                        Text("\(formatedAmbiente)%")
                                            .foregroundColor(Color("Ambiente"))
                                            .fontWeight(.bold)
                                            .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .caption))
                                    }
                                    if viewModel.ganaAmbiente{
                                        Image(systemName: "books.vertical")
                                            .font(.system(size:20))
                                        let formatedAmbiente = String(format: "%.2f", viewModel.porcMemoria)
                                        Text("\(formatedAmbiente)%")
                                            .foregroundColor(Color("Memoria"))
                                            .fontWeight(.bold)
                                            .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .caption))
                                        
                                    }
                                                                      
                                    
                                    
                                }
                            }
                            .onAppear(){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    
                                    withAnimation(.easeInOut(duration: 3.0)) {
                                        if viewModel.ganaMemoria {
                                            self.trimAmountSmallFirstCircle = viewModel.porcAmbiente / 100
                                            print("GANO segundo lugar MEMORIA")
                                        }
                                        if viewModel.ganaAmbiente {
                                            self.trimAmountSmallFirstCircle = viewModel.porcMemoria / 100
                                            print("GANO segundo lugar  AMBIENTE")
                                        }
                                        if viewModel.ganaGenero {
                                            self.trimAmountSmallFirstCircle = viewModel.porcAmbiente / 100
                                            print("GANO segundo lugar  GENERO")
                                        }
                                    }
                                }
                            }
                            if viewModel.ganaMemoria || viewModel.ganaGenero {
                                Text("Medio ambiente")
                                    .foregroundColor(Color("Ambiente"))
                                    .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .title3))
                            }
                            
                            if viewModel.ganaAmbiente {
                                Text("Memoria, paz y conflicto")
                                    .foregroundColor(Color("Memoria"))
                                    .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .title3))
                            }
                        }
                        // SECOND CIRCLE
                        VStack{
                            ZStack{
                                ZStack {
                                    
                                    Circle()
                                        .stroke(Color.gray.opacity(0.1),lineWidth: 10)
                                    if viewModel.ganaMemoria || viewModel.ganaAmbiente{
                                        Circle()
                                            .stroke(
                                                Color("Genero").opacity(0.3),
                                                lineWidth: 10
                                            )
                                        Circle()
                                            .trim(from: 0, to: trimAmountSmallSecondCircle)
                                            .stroke(
                                                Color("Genero").opacity(1),
                                                style: StrokeStyle(
                                                    lineWidth: 10,
                                                    lineCap: .round
                                                )
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    if viewModel.ganaGenero{
                                        Circle()
                                            .stroke(
                                                Color("Memoria").opacity(0.3),
                                                lineWidth: 10
                                            )
                                        Circle()
                                            .trim(from: 0, to: trimAmountSmallSecondCircle)
                                            .stroke(
                                                Color("Memoria").opacity(1),
                                                style: StrokeStyle(
                                                    lineWidth: 10,
                                                    lineCap: .round
                                                )
                                            )
                                            .rotationEffect(.degrees(-90))
                                    }
                                    
                                }
                                .frame(width: 90,height: 90)
                                .padding(15)
                                .overlay(RoundedRectangle(cornerRadius: 300).stroke(Color(viewModel.ColorCategoryThird), lineWidth: 1))
                                VStack{
                                    if viewModel.ganaMemoria || viewModel.ganaAmbiente {
                                        Image(systemName: "flag")
                                            .font(.system(size:20))
                                        let formatedGenero = String(format: "%.2f", viewModel.porcGenero)
                                        Text("\(formatedGenero)%")
                                            .foregroundColor(Color("Genero"))
                                            .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    }
                                    
                                    if viewModel.ganaGenero {
                                        Image(systemName: "books.vertical")
                                            .font(.system(size:20))
                                        let formatedGenero = String(format: "%.2f", viewModel.porcMemoria)
                                        Text("\(formatedGenero)%")
                                            .foregroundColor(Color("Memoria"))
                                            .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    }
                                
                                }
                            }.onAppear(){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    
                                    withAnimation(.easeInOut(duration: 3.0)) {
                                        if viewModel.ganaMemoria || viewModel.ganaAmbiente{
                                            self.trimAmountSmallSecondCircle = viewModel.porcGenero / 100
                                            print("GANO Tercer lugar Genero")
                                        }
                                        if viewModel.ganaGenero {
                                            self.trimAmountSmallSecondCircle = viewModel.porcMemoria / 100
                                            print("GANO Tercer lugar  Memoria")
                                        }
                                    }
                                }
                            }
                            
                            if viewModel.ganaMemoria || viewModel.ganaAmbiente{
                                Text("Género e inclusión")
                                    .foregroundColor(Color("Genero"))
                                    .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .title3))
                            }
                            if viewModel.ganaGenero {
                                Text("Memoria, paz y conflicto")
                                    .foregroundColor(Color("Memoria"))
                                    .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .title3))
                            }
                            
                            Spacer()
                        }
                        
                    }//FIN VStack circles
                    .padding(.top,-10)
                    
                }//FIN HSTACK Circle Sliders
                .padding(.horizontal,10)
                
                //FIN PRUEBA CON 1 solo view de circle
            
            Group{
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                    }
//                    Group{
//                        Text("Interacciones totales: \(viewModel.ReactionsCurrentUser.count)")
//                        Text("Total comentarios: \(viewModel.UserComments.count)")
//                        Text("Contenidos guardados: \(viewModel.PostsGuardados.count)")
//                    }
                   
                }
                .padding(.horizontal,10)
                .font(.custom("SofiaSans-Regular",size: 12,relativeTo: .title))
            }
            
            Group{
                VStack{
                    HStack{
                        Text("Guardados")
                            .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                        Spacer()
                    }.padding()
                    
                    
                    if viewModel.PostsGuardados.isEmpty {
                        Text("Aun no tienes contenido guardado.")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title))
                            .foregroundColor(Color("Text"))
                    } else {
                        ScrollView(.horizontal){
                            
                            if viewModel.PostsGuardados != []{
                                HStack(spacing: 0){
                                    ForEach(viewModel.PostsGuardados, id: \.self){ post in
                                        
                                        ForEach(contentviewmodel.postsAll.filter{$0.id == post}){ post in
                                            
                                            if post.type == "image"{
                                                NavigationLink(destination: PostCardImageDetailView(model: post), label: {
                                                    PostCardImage(model: post)
                                                        .frame(width:280,height: 350)
                                                } )
                                            } else if post.type == "video"{
                                                NavigationLink(destination: PostCardVideoDetailView(model: post), label: {
                                                    PostCardVideo(model: post)
                                                        .frame(height: 330)
                                                        .padding(.top,-20)
                                                })
                                            } else if post.type == "podcast"{
                                                NavigationLink(destination: PostCardPodcastDetail(model: post), label: {
                                                    PostCardPodcast(model: post)
                                                        .frame(width:330)
                                                })
                                            }
                                            
                                        }
                                    }.padding(.leading,15)
                                }.padding(.bottom,10)
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    
                    //Loop throw array to find posts saved by id
                    //Show each posts
                    
                }// FIN VStack Staved posts
                
                HStack{
                    Text("Imagen de la semana")
                        .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                    Spacer()
                }.padding()
                
//                Text("Image values - \(contentviewmodel.postsAll.filter{ $0.type == "image" })")
                
                
                ForEach(contentviewmodel.postsAll.prefix(1).filter{$0.type == "image"}){ post in
                    NavigationLink(destination: PostCardImageDetailView(model: post), label: {
                        PostCardImage(model: post) } )
                }.padding(.horizontal,25)
                
                
                HStack{
                    Text("Videos recomendados")
                        .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                    Spacer()
                }.padding()
                
                ScrollView(.horizontal){
//                    LazyVGrid(columns: Columns, spacing: 15){
                    HStack{
                        ForEach(contentviewmodel.postsAll.shuffled().filter{$0.type == "video"}.prefix(6)) { post in
                            
                            NavigationLink(destination: PostCardVideoDetailView(model: post), label: {
                                PostCardVideo(model: post)
                                    .frame(width:120)
                            } )
                        }
                    }
                    .padding(.bottom,10)
                   .padding(.horizontal,25)
                }
                
                
                HStack{
                    Text("Podcast sugeridos")
                        .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                    Spacer()
                }.padding()
                
                ForEach(contentviewmodel.postsAll.shuffled().filter{$0.type == "podcast"}.prefix(3)) { post in
                    
                  
                    
                    NavigationLink(destination: PostCardPodcastDetail(model: post), label: {
                        PostCardPodcast(model: post)
                        //                            .frame(width:150)
                    } )
                       
                    
                }
                .padding(.horizontal,35)
                
            }
            
            .environmentObject(viewModel)
            
        }// END SCROLLVIEW
        .sheet(isPresented: $isPresentedInfoU) {
            InfoViewUser()
                .presentationDetents([.fraction(0.6)])
                .presentationBackground(.black.opacity(0.8))
                .presentationCornerRadius(20)
        }
        .fullScreenCover(isPresented: $showEditProfile){
            EditProfileView()
        }
        
        .onAppear(){
            viewModel.fetchUser()
        }
    }
}


struct InfoViewUser: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Navega por contenidos exclusivos creados y ajustados a tu perfil e intereses junto a BaudoAP. Revisa tus reacciones y tipo de contenidos que más visitas y compartes.")
                    .foregroundColor(.white)
                    .font(.custom("SofiaSans-Medium",size: 18,relativeTo: .title2))
                    .padding(.bottom,20)
                
                    .overlay(Rectangle().frame(maxWidth: .infinity,maxHeight: 1, alignment: .bottom).foregroundColor(Color("AccentColor")), alignment: .bottom)
                
            }
            .padding(.horizontal,40)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40,height: 40, alignment: .trailing)
                    .foregroundColor(Color("Buttons"))
            }.padding(.top, 30)
        }
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(AuthViewModel())
    }
}
