//
//  CartButton.swift
//  BaudoAP
//
//  Created by Codez on 2/06/23.
//

import SwiftUI

struct CartButton: View {
    
    @EnvironmentObject var cartmanager: CartManager
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart.fill")
                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                .foregroundColor(.black)
                .offset(x: 0)
                .offset(y: 0)
                
            
            if cartmanager.numberOfProducts > 0 {
                Text("\(cartmanager.numberOfProducts)")
                    .foregroundColor(.black)
                    .frame(width:20, height: 20)
                    .background(.white)
                    .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                    .cornerRadius(50)
                    .offset(x: 10)
                    .offset(y: -10)
            }
        }
        .padding(.vertical,18)
        .padding(.horizontal,15)
        .background(Color("Yellow"))
        .cornerRadius(50)

    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
            .environmentObject(CartManager())
            
    }
}
