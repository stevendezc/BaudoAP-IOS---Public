//
//  PostImageDetailViewImage.swift
//  BaudoAP
//
//  Created by Codez on 12/03/23.
//

import SwiftUI
import Kingfisher

struct PostCardImageDetailViewImage: View {
    
    var model: Post
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            
            ScrollView(.horizontal){
                KFImage( URL(string: model.main_media))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                //                .border(Color.red, width: 3)
                
            }
            VStack{
                HStack{
                    Button("←"){
                        isPresented = false
                    }
                    .padding(.horizontal,5)
                    .padding(.vertical,1)
                    .foregroundColor(Color("Yellow"))
                    .background(Color.black)
                    .cornerRadius(30)
                    .font(.system(size: 30))
                    .padding(.leading,20)
                    
                    Spacer()
                    
//                    Image("BaudoImage").padding(.trailing,20)
                }
                .padding(.vertical,40)
                Spacer()
                HStack{

                    Spacer()
                }
            }
        }
    }
}

struct PostCardImageDetailViewImage_Previews: PreviewProvider {
    static var previews: some View {
        PostCardImageDetailViewImage(model: Post(thumbnail:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1",thumbnail2:  "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FThumb1.png?alt=media&token=2bf3ad6b-51b2-4727-9d80-29755377c5c1",author: "Foto por: BaudoAP", location: "Triguba,Choco", main_media: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Imagenes%2FComicLargo.png?alt=media&token=0e738d91-f4b7-43c6-9324-05dd3c0c2889", type: "Imagen", description: "Esta es una breve descripcion de contenido de imagen para pruebas en el postCardImage y para solo visualizar coo se veria el texto en las cartas del home", category: "Medio Ambiente",title: "title",creation_date: Date()), isPresented: .constant(true))
    }
}
