//
//  PostCardPodcastDetail.swift
//  BaudoAP
//
//  Created by Codez on 25/03/23.
//

import SwiftUI
import Kingfisher
import AVFoundation
//import Firebase
import FirebaseStorage
import AVKit


enum Utility {
    static func formatSecondsToHMS(_ seconds: TimeInterval) -> String {
        
        if seconds.isNaN || seconds.isInfinite || seconds == 0.0
        {
            return "00:00"
        }
        let secondsInt:Int = Int(seconds.rounded(.towardZero))
        
        let dh: Int = (secondsInt/3600)
        let dm: Int = (secondsInt - (dh*3600))/60
        let ds: Int = secondsInt - (dh*3600) - (dm*60)
        
        let hs = "\(dh > 0 ? "\(dh):" : "")"
        let ms = "\(dm<10 ? "0" : "")\(dm):"
        let s = "\(ds<10 ? "0" : "")\(ds)"
        
        return hs + ms + s
    }
}

struct PostCardPodcastDetail: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    @State var audioPlayer = AVPlayer()
    
    @State var isPlaying : Bool = false
    
    
    @State private var blurAmount = 0.0
    
    @State var value: Double = 0.0
    
    @State private var durationSec: Double = 0.0
    
    @State private var isEditing: Bool = false
    
    let timer = Timer
        .publish(every: 1.0, on: .main, in: .common)
        .autoconnect()
    
    @StateObject var viewModel = AuthViewModel()
    @ObservedObject var contentviewmodel = ContentViewModel()
    var model: Post
    
    var body: some View {
        
        ScrollViewReader { reader in
            ScrollView{
                
                Spacer(minLength: 20)
                
                Group{
                    VStack(alignment: .leading){
                        Group{
                            HStack{
                                    KFImage(URL(string: model.thumbnail))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:100)
                                
                                VStack(alignment: .leading,spacing: 5) {
                                    HStack{
                                        Text(model.title)
                                            .font(.custom("SofiaSans-Bold", size: 18,relativeTo: .title))
                                            .fontWeight(.heavy)
                                        Spacer()
                                        Button {
                                            playPause()
                                            print("Button Pressed")
                                            print(audioPlayer.currentTime().seconds)
                                        } label: {
                                            if isPlaying {
                                                Image("Pause")
                                            } else {
                                                Image("Play")
                                            }
                                        }
                                        .padding(.top,-60)
                                        .foregroundColor(Color("Buttons"))
                                        
                                    }
                                    Text("Publicado: \(model.creation_date.formatted(.dateTime.month().year()))")
                                        .font(.caption)
                                        .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .caption))
                                        .padding(.bottom,10)
                                    //                        Text(model.creationDateString)
                                    //                            .font(.custom("SofiaSans-Medium",size: 14,relativeTo: .caption))
                                    
                                    
                                }.foregroundColor(Color("Text"))
                                    .multilineTextAlignment(.leading)
                                
                            }
                        }
                        
                        
                        Group{
                            Slider(value: $value, in: 0...durationSec) { editing in
                                print("editing",editing)
                                isEditing = editing
                                if !editing {
                                    audioPlayer.seek(to:  CMTimeMakeWithSeconds(value, preferredTimescale: 1000))
                                    print("new value",value)
                                }
                            }
                            .padding(8)
                            .background(Color("BackgroundCards").opacity(0.4))
                            .foregroundColor(Color("Text"))
                            .cornerRadius(20)
                            
                            HStack{
                                Text(Utility.formatSecondsToHMS(value))
                                    .font(.custom("SofiaSans-Regular",size: 12,relativeTo: .caption))
                                Spacer()
                                Text(Utility.formatSecondsToHMS(durationSec))
                                    .font(.custom("SofiaSans-Regular",size: 12,relativeTo: .caption))
                            }
                            
                            HStack{
                                Spacer()
                                HStack(alignment: .center,spacing: 20){
                                    Spacer()
                                    
                                    Button{
                                        
                                        if !viewModel.ReactionsCurrentUser.contains(model.id ?? ""){
                                            viewModel.likePost(postId: model.id ?? "")
                                        } else {
                                            viewModel.dislikePost(postId: model.id ?? "")
                                        }
                                        
                                        
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(viewModel.ReactionsCurrentUser.contains(model.id ?? "") ? Color("Yellow") : Color.white.opacity(0.8))
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
                                            .foregroundColor(viewModel.PostsGuardados.contains(model.id ?? "") ? Color("Yellow") : Color.white.opacity(0.8))
                                    }
                                    
                                    
                                    ShareLink(
                                        item: model.location,
                                        subject: Text(model.thumbnail),
                                        message: Text("\(model.location)\n\n\n\(model.description)\n\n\n\(model.main_media)"),
                                        preview: SharePreview(model.location)
                                    )
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white.opacity(0.8))
                                    
                                    Spacer()
                                    
                                }
                                
                                .frame(width:150,height: 30)
                                .padding(10)
                                .background(Color("BackgroundCards").opacity(0.8))
                                .foregroundColor(Color("Text"))
                                .cornerRadius(20)
                                
                                Spacer()
                            } // FIN REACTIONS
                            Spacer(minLength: 20)
                            VStack{
                                HStack{
                                    Spacer()
                                }
                                Text(model.description)
                                    .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                    .padding(10)
                                    .background(Color("BackgroundCards").opacity(0.4))
                                    .foregroundColor(Color("Text"))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    .padding(20)
                    .background(Color("BackgroundCards").opacity(0.7))
                    .cornerRadius(20)
                    .padding(15)
                } // FIN Section 1
                
                // PROBLEM
                VStack{
                    Group{
                        HStack{
                            Text("Comentarios").foregroundColor(Color("Text"))
                                .font(.custom("SofiaSans-Bold",size: 24,relativeTo: .title)).id("commentsImages")
                            Spacer()
                        }.padding(20)
                    }
                    
                    Group{
                        VStack(alignment: .leading){
                            HStack{
                                Spacer()
                            }
                            Group{
                                if contentviewmodel.comments.isEmpty {
                                    Text("Sé el primero en comentar.")
                                        .multilineTextAlignment(.leading)
                                        .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .body))
                                } else {
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
                                                    
                                                    if viewModel.currentUserEmail == comment.author_email || viewModel.currentUserEmail == "baudoagenciap@gmail.com" || viewModel.currentUserEmail == "stevendezc@gmail.com" {
                                                        
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
                                                                .background(Color("BackgroundCardsNavDark").opacity(0.4))
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
                                                        }
                                                    }else {
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
                                                        .background(Color("BackgroundCardsNavDark").opacity(0.4))
                                                        .cornerRadius(20)
                                                        
                                                    }
                                                }
                                            }
                                            .padding(5)
                                           .cornerRadius(20)
                                        }
                                    }
                                }
                            }
                        }.padding(20)
                            .background(Color("BackgroundCards").opacity(0.4))
                            .foregroundColor(Color("Text"))
                            .cornerRadius(20)
                    }
                }
                .padding(20)
                .background(Color("BackgroundCards").opacity(0.4))
                .cornerRadius(20)
                .padding(10)
                
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
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
            .background(
                KFImage( URL(string: model.thumbnail2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(-5)
                    .frame(width:UIScreen.main.bounds.width,
                           height:UIScreen.main.bounds.height)
                    .blur(radius: 1.0)
                    .opacity(0.2)
                
            )
            
            // TO COMMENT
            Group{
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
                        .background(Color("BackgroundCards").opacity(0.8))
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
                .padding(.horizontal,10)
            }//FIN Section3
        }
        .onTapGesture {
            // Dismiss the keyboard when tapping outside the text field
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .padding(.vertical,5)
        
        .background(Color("BackgroundColor").opacity(0.8))
        
        .onAppear(){
            viewModel.fetchUser()
            Task{
                try await contentviewmodel.fetchNewComments(post: model.id ?? "")
            }
            
            Task{
                await Play()
            }
            
        }
        .onReceive(timer){ (_) in
            
            if isPlaying {
                
                value = (CMTimeGetSeconds(audioPlayer.currentTime() ))
                
                let finAntes = durationSec - 30
                print("FIN ANTES \(finAntes)")
                if value.rounded() == finAntes.rounded(){
                    viewModel.playedUserPodcast(PostId: model.id ?? "")
                    print("EQUAL HERE ")
                }
                
                if value.rounded() == durationSec.rounded() {
                    //Uploads postID to firebase users info
                    viewModel.playedUserPodcast(PostId: model.id ?? "")
                    
                    audioPlayer.seek(to: .zero)
                    audioPlayer.pause()
                    self.isPlaying.toggle()
                    value = 0.0
                } else {
                                        print("Value = ",value)
                                        print("Duration= ", durationSec)
                }
            } else {
                isPlaying = false
            }
        }
        .onDisappear(){
            contentviewmodel.stopListener()
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func Play() async {
        let storage = Storage.storage().reference(forURL: self.model.main_media)
        
        
        storage.downloadURL { url, error in
            if error != nil {
                print(error ?? "Error")
            } else {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }
                catch{
                    //                    Report for an error
                    
                }
                
                audioPlayer = AVPlayer(url: url!)
                
                let asset = AVURLAsset(url: url!)
                
                audioPlayer.pause()
                //                    let durationSec = try await asset.load(.duration)
                //                    durationSec = CMTimeGetSeconds(asset.duration) - 4
                durationSec = CMTimeGetSeconds(asset.duration) - 4
                print("duration ", durationSec)
            }
        }
    }
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    }
    
    
    
}


struct PostCardPodcastDetail_Previews: PreviewProvider {
    static var previews: some View {
        
            PostCardPodcastDetail(model: Post(thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Podcasts%2FThumbnails%2FT1%20E1.jpg?alt=media&token=bcde90c8-4ca9-4bf6-baee-f8293ea886e0",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Podcasts%2FThumbnails%2FT1%20E1%20fondo%20(1).jpg?alt=media&token=9b48aa81-1774-4e5a-805f-f19b87bee7c0", author: "BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Videos%2FCopia%20de%20CHAGRA%201.mp4?alt=media&token=fc041a3d-8c5b-4fcc-86ad-954b4df28ee1", type: "Video", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title Video Prueba",creation_date: Date()))
        
    }
}



