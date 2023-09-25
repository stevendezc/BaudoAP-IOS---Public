//
//  PostCardImagePreload.swift
//  BaudoAP
//
//  Created by Codez Studio on 10/07/23.
//

import SwiftUI

struct PostCardImagePreload: View {
    
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                ProgressView()
                
                Spacer()
                HStack{
                    Spacer()
                }
            }
            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 220, maxHeight: 220, alignment: .topLeading)
            .background(Color(UIColor.lightGray).opacity((1.0)))
            .cornerRadius(20)
            
            
            ZStack(alignment: .leading){
                VStack{
                    HStack{
                        Spacer()
                        Text(" ")
                    }
                }
                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 190, maxHeight: 190, alignment: .topLeading )
                .background(Color(UIColor.lightGray).opacity((0.3)))
                .cornerRadius(20)
                
                VStack(alignment: .leading){
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text(" ")
                        }
                    }
                    .frame(width: 280,height: 30)
                    .background(Color(UIColor.lightGray).opacity(0.5))
                    .cornerRadius(20)
                    .padding(.top,20)
                    .padding(.horizontal,20)
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text(" ")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color(UIColor.lightGray).opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text(" ")
                        }
                    }
                    .frame(maxWidth: 250, maxHeight: 20)
                    .background(Color(UIColor.lightGray).opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    
                    VStack{
                        HStack{
                            Spacer()
                            Text(" ")
                        }
                    }
                    .frame(maxWidth: 170, maxHeight: 20)
                    .background(Color(UIColor.lightGray).opacity(0.5))
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                }
            }
            .padding(.top,-35)
        }
        .padding(.leading,20)
        .padding(.trailing,20)
        .padding(.bottom,20)
    }
}

struct PostCardImagePreload_Previews: PreviewProvider {
    static var previews: some View {
        PostCardImagePreload()
    }
}
