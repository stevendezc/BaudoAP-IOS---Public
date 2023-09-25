//
//  PostCardPodcastDetailView.swift
//  BaudoAP
//
//  Created by Codez on 25/03/23.
//

import SwiftUI
import SDWebImageSwiftUI 
 
struct PostCardPodcastDetailView: View {
    
    var model: Post
     
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                    WebImage(url: URL(string: model.Thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:130)
        //                .border(Color.red, width: 3)
                    
                    VStack(alignment: .leading,spacing: 5) {
                        
                            Text(model.Title).font(.title)
                            Image(systemName: "play")
                        
                        
    //                    Text(model.CreationDate).font(.callout)
    //                    Text(model.Description).font(.caption)
                        Image(systemName: "play.circle")
                    }.foregroundColor(Color("Text"))
                    
                    
                        Spacer()
                }
                .padding(15)
                .background(Color("BackgroundCards"))
                .cornerRadius(20)
            
            Text("Here Comments")
        }
        
    
    }
}


struct PostCardPodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        PostCardPodcast(model: Post(id: "10",Thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Podcasts%2FRecurso%2027%402x-8%201.png?alt=media&token=ef46631c-aaee-42fb-8b3d-5213653fe7ba", Author: "BaudoAP", Location: "Triguba,Choco", MainMediaUrl: "https://firebasestorage.googleapis.com/v0/b/baudoapswift.appspot.com/o/Pic2-50.jpg?alt=media&token=7ec8709e-9dc6-4ce3-af94-566d48251d60", Typo: "Imagen", Description: "Esta es una breve descripcion de contenido de Podcast para pruebas en el postCardPodcast y para solo visualizar como se veria el texto en las cartas del home", Category: "Medio Ambiente",Title: "Los rastros del cambio climatico",CreationDate: "23/Marzo/2023"))
        
    }
}



