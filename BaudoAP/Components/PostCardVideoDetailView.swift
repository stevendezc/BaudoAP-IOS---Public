//
//  PostCardVideoDetailView.swift
//  BaudoAP
//
//  Created by Codez on 22/03/23.
//

import SwiftUI
import AVKit
import Kingfisher


struct PostCardVideoDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State var player: AVPlayer?
    
    @ObservedObject var contentviewmodel = ContentViewModel()
    @StateObject var viewModel = AuthViewModel()
    
    var model: Post
    
    
    var body: some View {
        
                ScrollViewReader { reader in
                    ScrollView{

                        ZStack(alignment: .topTrailing){
   
                            VideoPlayer(player: player)
//                                .ignoresSafeArea()
                                .aspectRatio(9/16, contentMode: .fill)
                                .cornerRadius(19)
                                .padding(.horizontal,12)
                        }
                        
                        
                        HStack{
                            Spacer()
                            HStack(alignment: .center,spacing: 20){
                                Spacer()
                                
                                Button{
                                    
                                    if !viewModel.ReactionsCurrentUser.contains(model.id ?? ""){
                                        print("Entre aqui para probar el like button si existe en reaction curren user array")
                                        viewModel.likePost(postId: model.id ?? "")
                                        print("luego de hacer el push like")
                                    } else {
                                        viewModel.dislikePost(postId: model.id ?? "")
                                    }
                                    
                                    
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(viewModel.ReactionsCurrentUser.contains(model.id ?? "") ? Color("Yellow") : Color.gray)
                                }
                               
                                Button{
                                    
                                    if !viewModel.PostsGuardados.contains(model.id ?? ""){
                                        viewModel.saved_posts(postID: model.id ?? "")
                                    } else {
                                        viewModel.removeReaction(postId: model.id ?? "")
                                    }
                                } label: {
                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(viewModel.PostsGuardados.contains(model.id ?? "") ? Color("Yellow") : Color.gray)
                                }
                                
                                
                                ShareLink(
                                    item: model.location,
                                    subject: Text(model.thumbnail),
                                    message: Text("\(model.location)\n\n\n\(model.description)\n\n\n\(model.main_media)"),
                                    preview: SharePreview(model.location)
                                )
                                .font(.system(size: 20))
                                .foregroundColor(Color.gray)
                                
                                Spacer()
                                    
                            }
                            
                            .frame(width:150,height: 30)
                            .padding(10)
                            .background(Color("BackgroundCards").opacity(0.8))
                            .foregroundColor(Color("Text"))
                            .cornerRadius(20)
                            
                            Spacer()
                        }
        
                        VStack(alignment: .leading,spacing: 5){
                            Text(model.location).font(.custom("SofiaSans-Bold",size: 22,relativeTo: .title3))
                            Text(model.description).font(.custom("SofiaSans-Regular",size: 15, relativeTo: .body))
                            Text("Foto por: \(model.author)")
                                .padding(.top,3)
                                .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .caption))
                            Text("Publicado: \(model.creation_date.formatted(.dateTime.month().year()))")
                                .font(.caption)
                                .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .caption))
                                .padding(.bottom,10)
                            
                            Image("Lines")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            Spacer()
                            Spacer()
                            
                            Text("Comentarios")
                                .font(.custom("SofiaSans-Bold",size: 24,relativeTo: .title)).id("comments")
                            
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Spacer()
                                }
                                
                                if !contentviewmodel.comments.isEmpty{
                                    VStack(alignment: .leading){
                                        
                                        ForEach(contentviewmodel.comments){ comment in
                                            
                                            HStack{
                                                VStack(){
                                                    if comment.userCommentPic != "" {
                                                        KFImage(URL(string: comment.userCommentPic))
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 40 ,height: 40)
                                                            .cornerRadius(50)
                                                            .padding(5)
                                                            .overlay(RoundedRectangle(cornerRadius: 50) .stroke(Color("Buttons"), lineWidth: 1))
                                                    } else {
                                                        Image("logoBaudoWhite")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .padding(10)
                                                            .foregroundColor(Color("Buttons"))
                                                            .frame(width: 40,height: 40,alignment: .center)
                                                            .clipShape(Circle())
                                                            .padding(2)
                                                            .cornerRadius(60)
                                                            .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                                                    }
                                                    Spacer()
                                                }
                                                
                                                
                                                VStack(alignment: .leading){
                                                    
                                                    if viewModel.currentUserEmail == comment.author_email || viewModel.currentUserEmail == "baudoagenciap@gmail.com" || viewModel.currentUserEmail == "stevendezc@gmail.com"{
                                                        
                                                        ZStack(alignment: .bottomTrailing){
                                                            Menu {
                                                                Button("Eliminar commentario") {
                                                                    contentviewmodel.deleteItem(commentId: comment.id)
                                                                }
                                                                
                                                            } label: {
                                                                VStack(alignment: .leading){
                                                                    Text(comment.userCommentName)
                                                                        .multilineTextAlignment(.leading)
                                                                        .font(.custom("SofiaSans-Black",size: 16,relativeTo: .caption))
                                                                    
                                                                    Text(comment.text)
                                                                        .multilineTextAlignment(.leading)
                                                                        .font(.custom("SofiaSans-Regular",size: 14,relativeTo: .body))
                                                                    
                                                                }
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(10)
                                                                .background(Color("BackgroundCards").opacity(0.2))
                                                                .cornerRadius(20)
                                                                
                                                            }
                                                            
                                                            Menu {
                                                                Button("Eliminar commentario") {
                                                                    contentviewmodel.deleteItem(commentId: comment.id)
                                                                }
                                                                
                                                            } label: {
                                                                Image(systemName: "trash.fill")
                                                                    .font(.system(size: 10))
                                                                    .foregroundColor(Color("Text"))
                                                            }
                                                            
    //
                                                            
                                                        }
                                                        
                                                    }else {
                                                        VStack(alignment: .leading){
                                                            //
                                                            Text(comment.userCommentName)
                                                                .multilineTextAlignment(.leading)
                                                                .font(.custom("SofiaSans-Black",size: 16,relativeTo: .caption))
                                                            
                                                            Text(comment.text)
                                                                .multilineTextAlignment(.leading)
                                                                .font(.custom("SofiaSans-Regular",size: 14,relativeTo: .body))
                                                        }
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(10)
                                                        .background(Color("BackgroundCards").opacity(0.2))
                                                        .cornerRadius(20)
                                                        
                                                    }
                                                }
                                                
                                            }
                                            
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(5)
                                            .background(Color("BackgroundCards").opacity(0.2))
                                            .cornerRadius(20)
                                            
                                        }
                                        
                                    }
                                    .padding(5)
                                }
                                else {
                                    Text("Sé el primero en comentar.")
                                        .multilineTextAlignment(.leading)
                                        .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .body))
                                }
                                
                            }.padding(5)
                                .background(Color("BackgroundCards").opacity(0.2))
                                .foregroundColor(Color("Text"))
                                .cornerRadius(20)
                        }
                        //.border(Color.red, width: 3)
                        .padding(.horizontal,20)
        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 100)){
                                    reader.scrollTo("comments", anchor: .top)
                                }
        
                            }, label: {
                                Image(systemName: "message.fill")
                                    .padding(6)
                                    .padding(.vertical,1)
                                    .foregroundColor( Color("Yellow"))
                                    .background( Color.black)
                                    .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color("Buttons"),lineWidth: 1))
                                    .cornerRadius(35)
                                    .font(.system(size: 15))
                            })
                        }
                    }
        
                .onAppear(){
                    
                    viewModel.fetchUser()
                    player?.play()
                    Task {
                       try await contentviewmodel.fetchNewComments(post: model.id ?? "")
                    }
                    print("onAppear2")
                    
                    let URLS: String = model.main_media
//                    let url = URL(string: "https://example.com/video.mp4")!
                    
                    player = AVPlayer(url: URL(string: URLS)!)
                    
                    player?.play()
                    
                    setupAudioSession()
                }
                .onDisappear(){
                    player?.pause()
                    contentviewmodel.stopListener()
                }
        
                VStack(alignment: .leading){
                    HStack{
                        
                        
                        if viewModel.currentUser?.user_pic == "" {
                            //                            Text("\(viewModel.currentUser?.user_pic ?? "NO")")
                            Image("logoBaudoWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .foregroundColor(Color("Buttons"))
                                .frame(width: 35,height: 35,alignment: .center)
                                .clipShape(Circle())
                                .padding(2)
                                .cornerRadius(60)
                                .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                        } else {
                            KFImage(URL(string: viewModel.currentUser?.user_pic ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35 ,height: 35)
                                .cornerRadius(60)
                                .padding(2)
                                .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                        }
                        
                        
                        TextField("Agregar comentario",text: $contentviewmodel.text)
                            .foregroundColor(Color("Text"))
                            .padding(10)
                            .background(Color("BackgroundCards"))
                            .cornerRadius(19)
                            .onSubmit {
                                // Dismiss the keyboard when the Return key is pressed
                                if contentviewmodel.text != ""{
                                    contentviewmodel.pushComment(post: model.id ?? "", author: viewModel.currentUser?.name ?? "")
                                    withAnimation(.easeIn(duration: 2000)){
                                        reader.scrollTo("commentsImages", anchor: .top)
                                    }
                                    hideKeyboard()
                                } else {
                                    hideKeyboard()
                                }
                            }
                        Button{
                            if contentviewmodel.text != ""{
                                contentviewmodel.pushComment(post: model.id ?? "", author: viewModel.currentUser?.name ?? "")
                                withAnimation(.easeIn(duration: 2000)){
                                    reader.scrollTo("commentsImages", anchor: .top)
                                }
                                hideKeyboard()
                                //                print("Pusshed Comment YEYYYY",model.id ?? "")
                            } else {
                                hideKeyboard()
                            }
                                       
                        } label: {
                            Text("Enviar")
                        }
                            .buttonStyle(.borderedProminent)
                    }
                    .padding(.bottom,5)
                    .padding(.horizontal,10)
        
                }
            }
//                .onTapGesture {
//                    // Dismiss the keyboard when tapping outside the text field
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }
    }
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
    }
}
    
    
    struct PostCardVideoDetailView_Previews: PreviewProvider {
        static var previews: some View {
            PostCardVideoDetailView(model: Post(thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Videos%2FScreenshot%202023-03-23%20at%2011.33.20%20PM.png?alt=media&token=3e857497-6146-46c5-889d-fa55a44abc05",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1", author: "BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Videos%2FCopia%20de%20CHAGRA%201.mp4?alt=media&token=fc041a3d-8c5b-4fcc-86ad-954b4df28ee1", type: "Video", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title Video Prueba",creation_date: Date()))
        }
    }
