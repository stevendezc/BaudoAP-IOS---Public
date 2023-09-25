//
//  PostCardPodcast.swift
//  BaudoAP
//
//  Created by Codez on 24/03/23.
//

import SwiftUI
import Kingfisher

struct PostCardPodcast: View {
    
    var model: Post
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            HStack{
                KFImage(URL(string: model.thumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:110)
                    .cornerRadius(9)
                //                .border(Color.red, width: 3)
                
                VStack(alignment: .leading,spacing: 5) {
                    Text(model.title)
                        .font(.custom("SofiaSans-Bold", size: 18,relativeTo: .title))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                    Text(model.creationDateString)
                        .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .caption))
                        .multilineTextAlignment(.leading)
                    
                    Text(model.description)
                        .font(.custom("SofiaSans-Regular",size: 13,relativeTo: .body))
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                }.foregroundColor(Color("Text"))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            
            if viewModel.PodcastsListenedGuardados.contains(model.id ?? "") {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("Yellow"))
                    .font(.system(size:30))
                    .padding(5)
            }
                
        }.onAppear{
            print("Viewmodel PodcastsListenedGuardados \(viewModel.PodcastsListenedGuardados)")
            viewModel.fetchUser()
        }
//        .environmentObject(AuthViewModel())
    }
}

struct PostCardPodcast_Previews: PreviewProvider {
    static var previews: some View {
        
        PostCardPodcast(model: Post(thumbnail: "https://baudoap.com/wp-content/uploads/2023/01/GUERRILLERO-IMPASIBLE.jpg",thumbnail2:  "https://baudoap.com/wp-content/uploads/2023/01/GUERRILLERO-IMPASIBLE.jpg", author: "BaudoAP", location: "Triguba,Choco", main_media: "https://baudoap.com/wp-content/uploads/2022/12/Audio-3.mp3", type: "Imagen", description: "Esta es una breve descripcion de ", category: "Medio Ambiente",title: "Los ",creation_date: Date()))
        
    }
}



