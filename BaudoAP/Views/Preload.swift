//
//  Preload.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI


struct Preload: View {
    @State var isActive : Bool = false
    @State private var size = 0.2
    @State private var opacity = 0.0
    
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            Base()
        } else {
            VStack {
                VStack {
                    
                    Image("LogoBaudo")
                        .font(.system(size: 40))
//                  Text("HOY").foregroundColor(.black)
//                  Text(Date.now.formatted(.dateTime.weekday().day().month().year())).font(.custom(,size: 15,relativeTo: .title)).foregroundColor(.black)
                }
                
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        self.size = 0.7
                        self.opacity = 1.0
                    }
                }
            }
            .background(
                    Image("Fondo")
                        .ignoresSafeArea()
                )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct Preload_Previews: PreviewProvider {
    static var previews: some View {
        Preload()
    }
}
