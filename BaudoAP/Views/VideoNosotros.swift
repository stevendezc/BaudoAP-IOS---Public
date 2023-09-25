//
//  VideoNosotros.swift
//  BaudoAP
//
//  Created by Codez on 1/04/23.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    var videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        let request = URLRequest(url: youtubeURL)
        uiView.load(request)
    }
}

struct VideoNosotros: View {
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
            }
            YoutubePlayer(videoID: "vD7gBZ4oRWM").cornerRadius(30)
                .frame(height: 300).padding(10)
            
            VStack(alignment: .leading){
                
                HStack{
                    Image("LogoNosotros")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                    Text("Baudó Agencia Pública")
                        .font(.custom("SofiaSans-Bold",size: 18,relativeTo: .title)).padding()
                }
                Text("Hacemos periodismo que conecta")
                    .multilineTextAlignment(.leading)
                    .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                    .padding(.bottom,5)
                    .foregroundColor(Color("Yellow"))
                    .padding(.bottom,20)
                    .overlay(Rectangle().frame(width: 50, height: 3, alignment: .bottom).foregroundColor(Color("Buttons")), alignment: .bottomLeading)
                    
                
                Text("Que se asume a sí mismo como un actor para la transformación social a través de una investigación comprometida y una comunicación innovadora para aportar a la construcción de una sociedad más justa.")
                    .multilineTextAlignment(.leading)
                    .font(.custom("SofiaSans-Medium",size: 16,relativeTo: .body))
                    .foregroundColor(Color("Text"))
                    .padding(.top,30)
            }
            .padding(.horizontal,30)
            .padding(.bottom,50)
            .background(Color("BackgroundCards"))
            .cornerRadius(20)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
struct VideoNosotros_Previews: PreviewProvider {
    static var previews: some View {
        VideoNosotros()
    }
}
