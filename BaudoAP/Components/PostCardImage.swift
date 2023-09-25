//
//  SwiftUIView.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI
import Kingfisher

struct PostCardImage: View {
    
    var model: Post
    
    @State var isPresentedImage1: Bool = false
    
    var body: some View {
      
            VStack(alignment: .leading){
                
                KFImage(URL(string: model.thumbnail))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(19)
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Spacer()
                    }
                    .padding(.top,10)
                    Text(model.location)
                        .font(.custom("SofiaSans-Bold",size: 17,relativeTo: .title))
                    Text(model.description)
                        .font(.custom("SofiaSans-Regular",size: 14,relativeTo: .body))
                        .lineLimit(3)
                    
                    HStack{
                        Text("Foto por:")
                            .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .caption))
                        Text("\(model.author)").font(.custom("SofiaSans-Regular",size: 11,relativeTo: .caption))
                    }.padding(.bottom,-10)
                    
                    HStack{
                        Text("Publicado:")
                            .font(.custom("SofiaSans-Bold",size: 11,relativeTo: .caption))
                        Text("\(model.creation_date.formatted(.dateTime.month().year()))")
                            .font(.custom("SofiaSans-Medium",size: 11,relativeTo: .caption))
                        
                    }
                
                }.padding(EdgeInsets(top: -10, leading: 20, bottom: 20, trailing: 20))
 
            }
            .background(Color("BackgroundCards"))
            .cornerRadius(19)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color("Text"))
            .padding(.leading,20).padding(.trailing,20).padding(.bottom,20)
    }
}

struct PostCardImage_Previews: PreviewProvider {
    static var previews: some View {
        PostCardImage(model: Post(thumbnail:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FFoto5-50.jpg?alt=media&token=d045af3c-eb19-41fa-bd87-26053298f427",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1",author: "BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FFoto5-50.jpg?alt=media&token=d045af3c-eb19-41fa-bd87-26053298f427", type: "Imagen", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title",creation_date: Date() ))
    }
}
