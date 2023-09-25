//
//  PostCardComunidad.swift
//  BaudoAP
//
//  Created by Codez on 27/03/23.
//

import SwiftUI
import Kingfisher
import MessageUI
//extension Photo: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        ProxyRepresentation(exporting: \.image)
//    }
//}

struct PostCardComunidad: View {
    @Environment(\.openURL) var openURL
    
    @State private var showSheetFacebook = false
    @State private var showSheetInstagram = false
    @State private var showSheetTwitter = false
    @State private var showSheetWhatsapp = false
    
    var model: Users
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            
            
            if model.category == "productivos" {
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            KFImage( URL(string: model.thumbnail))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:110, height: 110)
                                .background(.white)
                                .cornerRadius(20)
                                .overlay( RoundedRectangle(cornerRadius: 20).stroke(Color("ComuPro"), lineWidth: 2))
                            
                            VStack(alignment: .leading){
                                Text(model.name)
                                    .foregroundColor(Color("ComuPro"))
                                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title))
                                Text(model.description)
                                    
                                    .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .body))
                            }.padding(.leading,10)
                        }
                        
                        Spacer()
                    }.padding(.top,5)

                    
                }
                
                    
                HStack{
                    if model.facebook != "" {
                        Button {
//                            LinkPasar = model.facebook
//                            print(LinkPasar)
                            showSheetFacebook.toggle()
//                            openURL(URL(string: model.facebook)!)
                        } label: {
                            Image("fb")
                        }
                    }
                    
                    if model.instagram != "" {
                        Button {
//                            self.LinkPasar = model.instagram
//                            showSheetInstagram.toggle()
                            showSheetInstagram.toggle()
//                            openURL(URL(string: model.instagram)!)
                        } label: {
                            Image("ig")
                        }
                    }
                    
                    if model.whatsapp != "" {
                        Button {
//                            self.LinkPasar = model.whatsapp
//                            showSheetWhatsapp.toggle()
                            showSheetWhatsapp.toggle()
//                            openURL(URL(string: model.whatsapp)!)
                        } label: {
                            Image("wa")
                        }
                    }
                    
                    if model.twitter != "" {
                        Button {
//                            self.LinkPasar = model.facebook
//                            showSheetTwitter.toggle()
                            showSheetTwitter.toggle()
                        } label: {
                            Image("tw")
                        }
                    }
                    
                    if model.number != "" {
                        Button {
                                let numberString = model.number
                                let telephone = "tel://"
                                let formattedString = telephone + numberString
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)
                        } label: {
                            Image(systemName:"phone.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,5)
                                .background(.black)
                                .cornerRadius(20)
                        }
                    }
                    
                    if model.email != "" {
                        Button {
                            EmailController.shared.sendEmail(subject: "Mensaje desde Baudo", body: "Escribe tu mensaje aqui", to: model.email)
                        } label: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,6)
                                .padding(.horizontal,4)
                                .background(.black)
                                
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                    Text(model.location)
                        .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .title))
                        .foregroundColor(Color("ComuPro"))
                   
                    Spacer()
                    
                    
                    if model.instagram != "" {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.instagram)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuPro"), lineWidth: 2))
                    } else {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.facebook)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuPro"), lineWidth: 2))
                    }
                }
            }
            
            if model.category == "cultura" {
                HStack{
                    VStack{
                        KFImage( URL(string: model.thumbnail))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:110, height: 110)
                            .background(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(Color("ComuCul"), lineWidth: 2)
                            )
                        Spacer()
                    }.padding(.top,5)
                    

                    VStack(alignment: .leading,spacing: 5) {
                        
                        Text(model.name)
                            .foregroundColor(Color("ComuCul"))
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title))
                        
                        Text(model.description)
                            
                            .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .body))
                    }.foregroundColor(Color("Text"))
                        .padding(.leading,10)
                        .padding(.trailing,15)
                }
                    
                HStack{
                    
                    if model.facebook != "" {
                        Button {
//                            LinkPasar = model.facebook
//                            print(LinkPasar)
                            showSheetFacebook.toggle()
//                            openURL(URL(string: model.facebook)!)
                        } label: {
                            Image("fb")
                        }
                    }
                    
                    if model.instagram != "" {
                        Button {
//                            self.LinkPasar = model.instagram
//                            showSheetInstagram.toggle()
                            showSheetInstagram.toggle()
//                            openURL(URL(string: model.instagram)!)
                        } label: {
                            Image("ig")
                        }
                    }
                    
                    if model.whatsapp != "" {
                        Button {
//                            self.LinkPasar = model.whatsapp
//                            showSheetWhatsapp.toggle()
                            showSheetWhatsapp.toggle()
//                            openURL(URL(string: model.whatsapp)!)
                        } label: {
                            Image("wa")
                        }
                    }
                    
                    if model.twitter != "" {
                        Button {
//                            self.LinkPasar = model.facebook
//                            showSheetTwitter.toggle()
                            showSheetTwitter.toggle()
                        } label: {
                            Image("tw")
                        }
                    }
                    
                    if model.number != "" {
                        Button {
                                let numberString = model.number
                                let telephone = "tel://"
                                let formattedString = telephone + numberString
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)
                        } label: {
                            Image(systemName:"phone.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,5)
                                .background(.black)
                                .cornerRadius(20)
                        }
                    }
                    
                    if model.email != "" {
                        Button {
                            EmailController.shared.sendEmail(subject: "Mensaje desde Baudo", body: "Escribe tu mensaje aqui", to: model.email)
                        } label: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,6)
                                .padding(.horizontal,4)
                                .background(.black)
                                .cornerRadius(20)
                        }
                    }
                    
                    Spacer()
                    Text(model.location)
                        .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .title))
                        .foregroundColor(Color("ComuCul"))
                   
                    Spacer()
                    
                    if model.instagram != "" {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.instagram)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuCul"), lineWidth: 2))
                    } else {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.facebook)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuCul"), lineWidth: 2))
                    }
                }
            }
            
            if model.category == "turismo" {
                HStack{
                    VStack{
                        KFImage( URL(string: model.thumbnail))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:110, height: 110)
                            .background(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(Color("ComuTur"), lineWidth: 2)
                            )
                       
                    }.padding(.top,5)
                    VStack(alignment: .leading,spacing: 5) {
                        
                        Text(model.name)
                            .foregroundColor(Color("ComuTur"))
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title))
                        
                        Text(model.description)
                            
                            .font(.custom("SofiaSans-Medium",size: 12,relativeTo: .body))
                    }.foregroundColor(Color("Text"))
                        .padding(.leading,10)
                        .padding(.trailing,15)
                }
                    
                HStack{
                    if model.facebook != "" {
                        Button {
//                            LinkPasar = model.facebook
//                            print(LinkPasar)
                            showSheetFacebook.toggle()
//                            openURL(URL(string: model.facebook)!)
                        } label: {
                            Image("fb")
                        }
                    }
                    
                    if model.instagram != "" {
                        Button {
//                            self.LinkPasar = model.instagram
//                            showSheetInstagram.toggle()
                            showSheetInstagram.toggle()
//                            openURL(URL(string: model.instagram)!)
                        } label: {
                            Image("ig")
                        }
                    }
                    
                    if model.whatsapp != "" {
                        Button {
//                            self.LinkPasar = model.whatsapp
//                            showSheetWhatsapp.toggle()
                            showSheetWhatsapp.toggle()
//                            openURL(URL(string: model.whatsapp)!)
                        } label: {
                            Image("wa")
                        }
                    }
                    
                    if model.twitter != "" {
                        Button {
//                            self.LinkPasar = model.facebook
//                            showSheetTwitter.toggle()
                            showSheetTwitter.toggle()
                        } label: {
                            Image("tw")
                        }
                    }
                    
                    if model.number != "" {
                        Button {
                                let numberString = model.number
                                let telephone = "tel://"
                                let formattedString = telephone + numberString
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)
                        } label: {
                            Image(systemName:"phone.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,5)
                                .background(.black)
                                .cornerRadius(20)
                        }
                    }
                    
                    if model.email != "" {
                        Button {
                            EmailController.shared.sendEmail(subject: "Mensaje desde Baudo", body: "Escribe tu mensaje aqui", to: model.email)
                        } label: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical,6)
                                .padding(.horizontal,4)
                                .background(.black)
                                .cornerRadius(20)
                        }
                    }
                    
                    Spacer()
                    Text(model.location)
                        .font(.custom("SofiaSans-Bold",size: 13,relativeTo: .title))
                        .foregroundColor(Color("ComuTur"))
                   
                    Spacer()
                    
                    if model.instagram != "" {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.instagram)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuTur"), lineWidth: 2))
                    } else {
                        ShareLink(
                            item: model.name,
                            subject: Text(model.location),
                            message: Text("\(model.name)\n\n\(model.location)\n\n\(model.description)\n\n\(model.facebook)"),
                            preview: SharePreview(model.location)
                        )
                        .onTapGesture(perform: simpleSuccess)
                        .font(.system(size: 20))
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10)
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .padding(.leading,8)
                        .foregroundColor(Color("Text"))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ComuTur"), lineWidth: 2))
                    }
                }
            }
        }
        .sheet(isPresented: $showSheetFacebook){
            SafariWebView(url: model.facebook)
        }
        
        .sheet(isPresented: $showSheetInstagram){
            SafariWebView(url: model.instagram)
        }
        
        .sheet(isPresented: $showSheetTwitter){
            SafariWebView(url: model.twitter)
        }
        .sheet(isPresented: $showSheetWhatsapp){
            SafariWebView(url: model.whatsapp)
        }
        
        
//      .frame(height: 220)
        .padding(15)
       
        .background(Color("BackgroundCards"))
        .cornerRadius(20)
    }
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
       
}

struct PostCardComunidad_Previews: PreviewProvider {
    static var previews: some View {
        PostCardComunidad( model: Users( thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Comunidad%2FLogo%20Casa%20Matriz.png?alt=media&token=bceaa152-4df6-43a4-b693-c3515cc5f62b", description: "Casa dedicada al desarrollo integral del ser y a la recuperación de el poder de las raíces a través de su trabajo como centro de desarrollo cultural en el municipio de Filandia Quindío y que por los últimos 4 años se ha dedicado al trabajo colectivo.", category: "turismo", name: "Casa Matriz", location: "Pereira, Risaralda", creation_date: Date(), instagram: "https://www.instagram.com/matriz__casa/", facebook: "https:", twitter: "https", whatsapp: "https://wa.me/3008405349",number: "3200457745", email: "Steven", website: ""))
            
    }
}
