//
//  PostCardVideo.swift
//  BaudoAP
//
//  Created by Codez on 20/03/23.
//


import SwiftUI
import Kingfisher

struct PostCardVideo: View {
    
    var model: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            KFImage( URL(string: model.thumbnail))
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        }
    }
}

struct PostCardVideo_Previews: PreviewProvider {
    static var previews: some View {
        PostCardVideo(model: Post(thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Videos%2FScreenshot%202023-03-23%20at%2011.33.20%20PM.png?alt=media&token=3e857497-6146-46c5-889d-fa55a44abc05",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1", author: "BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Videos%2FCopia%20de%20CHAGRA%201.mp4?alt=media&token=fc041a3d-8c5b-4fcc-86ad-954b4df28ee1", type: "Video", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title Video Prueba",creation_date: Date()))
    }
}
