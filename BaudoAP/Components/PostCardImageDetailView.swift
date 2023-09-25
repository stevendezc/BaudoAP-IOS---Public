//
//  PostCardImageDetailView.swift
//  BaudoAP
//
//  Created by Codez on 12/03/23.
//
import SwiftUI
import Kingfisher
import FirebaseAuth
import FirebaseFirestoreSwift
import CoreHaptics

struct PostCardImageDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.presentationMode) private var presentationModedelete: Binding<PresentationMode>
    
    @ObservedObject var contentviewmodel = ContentViewModel()
    @StateObject var viewModel = AuthViewModel()
//  @EnvironmentObject var viewModel: AuthViewModel
    
    let impactNotification = UINotificationFeedbackGenerator()
    
    var model: Post
    
    @State var isPresented: Bool = false
    @State var deleteUserSheet: Bool = false
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView{
                VStack(alignment: .leading){
                    
                    Button{
                        impactNotification.notificationOccurred(.success)
                        isPresented = true
                        
                    } label:{
                    VStack(alignment: .leading){
                        KFImage( URL(string: model.thumbnail))
                            .placeholder{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("ColorAccent")))
                            }
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(19)
                    }
                }
                    Button {
                        impactNotification.notificationOccurred(.success)
                        isPresented = true
                        
                        
                    } label: {
                        Image("Expand").resizable().frame(width: 25,height: 25)
                    }
                    .foregroundColor(Color("Buttons"))
                    .padding(.top,-50)
                    .padding(.leading,17)
                    
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
                                
                                
                                impactNotification.notificationOccurred(.success)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(viewModel.ReactionsCurrentUser.contains(model.id ?? "") ? Color("Yellow") : Color.gray)
                            }.onTapGesture(perform: simpleSuccess)
                           
                            Button{
                                if !viewModel.PostsGuardados.contains(model.id ?? ""){
                                    viewModel.saved_posts(postID: model.id ?? "")
                                } else {
                                    viewModel.removeReaction(postId: model.id ?? "")
                                }
                                impactNotification.notificationOccurred(.success)
                            } label: {
                                Image(systemName: "bookmark.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(viewModel.PostsGuardados.contains(model.id ?? "") ? Color("Yellow") : Color.gray)
                            }.onTapGesture(perform: simpleSuccess)
                            
                            
                            
                            Button{
                                impactNotification.notificationOccurred(.success)
                            } label:{
                                ShareLink(
                                    
                                    item: model.location,
                                    subject: Text(model.thumbnail),
                                    message: Text("\(model.location)\n\n\n\(model.description)\n\n\n\(model.main_media)"),
                                    preview: SharePreview(model.location)
                                ).onTapGesture(perform: simpleSuccess)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.gray)
                            }
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
                    }.padding(.horizontal,30)
                    
                    Text("Comentarios")
                        .font(.custom("SofiaSans-Bold",size: 24,relativeTo: .title)).id("commentsImages")
                        .padding(30)
                    
                    VStack(alignment: .leading,spacing: 5){
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
                
                .padding(5)
                
                .fullScreenCover(isPresented: $isPresented, onDismiss: {isPresented = false}, content: { PostCardImageDetailViewImage(model: model, isPresented: $isPresented).ignoresSafeArea()
                })
                
                .foregroundColor(Color("Text"))
                .padding(.horizontal,0)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        impactNotification.notificationOccurred(.success)
                        withAnimation(.easeInOut(duration: 100)){
                            reader.scrollTo("commentsImages", anchor: .top)
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
            
            // Footer bar to Comment
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
                        impactNotification.notificationOccurred(.success)
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
            .onAppear(){
                viewModel.fetchUser()
                Task {
                    try await contentviewmodel.fetchNewComments(post: model.id ?? "")
                }
            }
            .onDisappear(){
                contentviewmodel.stopListener()
            }
            
            .padding(5)
            Spacer()
            Spacer()
            
        }//Fin ScrollViewReader
        .onTapGesture {
            // Dismiss the keyboard when tapping outside the text field
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }//Fin Body
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
        
}

struct PostCardImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostCardImageDetailView( model: Post(id: "13",thumbnail:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FComic.png?alt=media&token=ad334fda-d0f6-4806-9adf-98a595803117",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1",author: "Foto por: BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapswift.appspot.com/o/Pic2-50.jpg?alt=media&token=7ec8709e-9dc6-4ce3-af94-566d48251d60", type: "Imagen", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title",creation_date: Date()))
//                            .environmentObject(AuthViewModel())
        }
    }
}

