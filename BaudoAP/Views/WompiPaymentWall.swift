//
//  WompiPaymentWall.swift
//  BaudoAP
//
//  Created by Codez Studio on 18/08/23.
//

import SwiftUI

struct WompiPaymentWall: View {
    
    var body: some View {
        NavegadorWeb(url: "https://mostros.co")
            .ignoresSafeArea()
        
            .navigationBarHidden(true)
    }
}

//#Preview {
//    WompiPaymentWall()
//}
