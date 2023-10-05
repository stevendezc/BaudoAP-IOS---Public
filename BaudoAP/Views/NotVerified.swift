//
//  NotVerified.swift
//  BaudoAP
//
//  Created by Codez Studio on 23/09/23.
//

import SwiftUI
import FirebaseAuth

struct NotVerified: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isuserverified = ""
    
    var body: some View {
        VStack{
            Text("Bienvenido a Baudo Ap")
                .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
                .foregroundStyle(Color("Text"))
            Text("por favor verifica tu correo electrónico dando click en el enlace en tu bandeja de entrada y/o spam, para confirmar tu correo electronico. ")
                .padding()
                .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .title2))
                .foregroundStyle(Color("Text"))
            
        }
        .padding(50)
    }
}

#Preview {
    NotVerified()
}
