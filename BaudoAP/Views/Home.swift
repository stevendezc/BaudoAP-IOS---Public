//
//  Home.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI
import AVKit
import FirebaseAnalytics
import FirebaseAnalyticsSwift

struct Home: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    @State private var isPresentedInfoH = false
    @State private var selectedCategory = "image"
    
    @ObservedObject var contentViewModel = ContentViewModel()
    @State var selectedOption = "image"
    @State private var showFilteredResults = true
    
    
    var filteredPosts: [Post] {
        if showFilteredResults {
            return contentViewModel.postsAll.filter({$0.type == selectedCategory})
        } else {
            //                return eventsviewmodel.events
            return self.filteredPosts
        }
    }
    @State var selectedTab = 0
    var body: some View {
        
        VStack {
            HStack{
                Picker("", selection: $selectedCategory){
                    Text("Imagen").tag("image")
                    Text("Video").tag("video")
                    Text("Podcast").tag("podcast")
                }
                
                Button{
                    isPresentedInfoH = true
                } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 25,height: 25, alignment: .trailing)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color("PickerBackground"))
            .padding(.horizontal,10)
            
            
            ScrollView{
                Text("").id("TopToScroll")
                
                    
                
                if filteredPosts.isEmpty  {
                    ForEach(0..<5) { index in
                        withAnimation(.easeIn(duration: 4)){
                            PostCardImagePreload()
                        }
                    }
                } else {
                    
                    if selectedCategory == "image"{
                        ForEach(filteredPosts) { post in
                            NavigationLink(destination: PostCardImageDetailView(model: post) , label: {
                                PostCardImage(model: post) } )
                        }
                    }
                    
                    if selectedCategory == "video"{
                        let ColumnsVidHome: [GridItem] = [
                            GridItem(.flexible(), spacing: nil, alignment: nil),
                            GridItem(.flexible(), spacing: nil, alignment: nil),
//                            GridItem(.flexible(), spacing: nil, alignment: nil),
                        ]
                        
                        LazyVGrid(columns: ColumnsVidHome, spacing: 10){
                            ForEach(filteredPosts) { post in
                                NavigationLink(destination: PostCardVideoDetailView(model: post) , label: {
                                    PostCardVideo(model: post)
                                    
                                } )
                            }
                        }
                        .padding(.horizontal,20)
                        .padding(.bottom,100)
                    }
                    
                    if selectedCategory == "podcast"{
                        ForEach(filteredPosts) { post in
                            NavigationLink(destination: PostCardPodcastDetail(model: post) , label: {
                                PostCardPodcast(model: post) } )
                        }
                    }
                }
                
            }.padding(.top,5)
                        
        }.onAppear(){
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
            let font = UIFont(name: "SofiaSans-Medium", size: 15.0)!          // Compute the right size
            UISegmentedControl.appearance().setTitleTextAttributes([.font: font], for: .normal)
        }
        .refreshable {
            Task{
                try await contentViewModel.fetchposts()
            }
        }
        .sheet(isPresented: $isPresentedInfoH) {
            InfoView()
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.black.opacity(0.8))
                .presentationCornerRadius(20)
        }
    }
} // FIN STRUCT

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack{
                Text("Navega por contenidos exclusivos creados y ajustados a tu perfil e intereses junto a BaudoAP. Revisa tus reacciones y tipo de contenidos que más visitas y compartes. ")
                    .foregroundColor(.white)
                    .font(.custom("SofiaSans-Medium",size: 18,relativeTo: .title2))
                    .padding(.bottom,20)
                
                    .overlay(Rectangle().frame(maxWidth: .infinity,maxHeight: 1, alignment: .bottom).foregroundColor(Color("AccentColor")), alignment: .bottom)
                
            }
            .padding(.horizontal,40)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40,height: 40, alignment: .trailing)
                    .foregroundColor(Color("Buttons"))
            }.padding(.top, 30)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
