//
//  PaymentMethod.swift
//  BaudoAP
//
//  Created by Codez Studio on 12/07/23.
//

import SwiftUI

struct PaymentMethod: View {
    
    @EnvironmentObject var cartmanager: CartManager
    
    @State private var pagoWompi = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Spacer(minLength: 30)
                HStack{
                    Spacer()
                    Text("Elige un medio de pago")
                        .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                    Spacer()
                }

                
//                HStack{
//                    NavigationLink(destination: PaymentMethodCard() , label: {
//                        Image("Logos Tarjetas")
//                            .resizable()
//                            .padding(5)
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 120, height: 120)
//                            .background(Color.white.opacity(0.8))
//                            .cornerRadius(20)
//
//                        Rectangle()
//                            .frame(width: 3, height: 80)
//                            .foregroundColor(.accentColor)
//
//                        Text("Paga con tus tarjetas")
//                            .padding(.trailing,20)
//                            .multilineTextAlignment(.leading)
//                            .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .body))
//
//                    } )
//                }
//                .foregroundColor(Color("Text"))
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
//
//
//                HStack{
//                    NavigationLink(destination: PaymentMethodPSE() , label: {
//                        Image("pselogo")
//                            .resizable()
//                            .padding(5)
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 120, height: 120)
//                            .background(Color.white.opacity(0.8))
//                            .cornerRadius(20)
//
//                        Rectangle()
//                            .frame(width: 3, height: 80)
//                            .foregroundColor(.accentColor)
//
//                        Text("Transfiere con tu cuenta de ahorros o corriente")
//                            .multilineTextAlignment(.leading)
//                            .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .body))
//                    } )
//                }
//                .foregroundColor(Color("Text"))
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
//
                Spacer(minLength: 100)
                HStack{
                    Spacer()
                    Button{
                        pagoWompi.toggle()
                    }label:{
                        Text("Open custom link to pay wompi.")
                    }
                    Spacer()
                }
                
                
                
            }
            
            .padding(.horizontal, 10)
            Spacer()
        }
        
        
    }
}

struct PaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethod()
    }
}
