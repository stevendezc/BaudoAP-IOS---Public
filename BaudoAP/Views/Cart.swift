//
//  Cart.swift
//  BaudoAP
//
//  Created by Codez on 2/06/23.
//

import SwiftUI

struct Cart: View {
    @EnvironmentObject var cartmanager: CartManager
    
    @State var pagoWompi = false
    @State var showingAlertpayed = false
    
    var body: some View {
        ScrollView{
            Text("Tu carrito")
                .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
            
            VStack(spacing: 10){
                HStack{
                    Text("Aviso importante")
                        .font(.custom("SofiaSans-Black",size: 23,relativeTo: .title2))
                    Spacer()
                }
                VStack{
                    HStack{
                        Text("Envíos disponibles solo en **COLOMBIA**, para envíos internacionales porfavor contáctanos")
                            .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .body))
                        Spacer()
                    }
                    .padding(.bottom,5)
                    
                    HStack{
                        Link("baudoagenciap@gmail.com", destination: URL(string: "mailto:baudoagenciap@gmail.com")!)
                            .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .body))
                            .padding(10)
                            .background(.black)
                            .cornerRadius(10.0)
                        Spacer()
                    }
                    
                    
                }
            }
            .padding(.vertical,20)
            .padding(.horizontal,20)
            .background(Color("Yellow"))
            .foregroundColor(.black)
            .cornerRadius(20.0)
            .padding()
            
            ScrollView{
                
                if cartmanager.cartproducts.count > 0 {
                        ForEach(cartmanager.cartproducts, id:\.self) { product in
                            ZStack(alignment: .bottomTrailing){
                                PostCardCartProduct(model: product)
                                    
                                    
                                Button{
                                    cartmanager.removeProduct(product: product)
                                } label:{
                                    Image(systemName: "trash.fill")
                                        .padding()
                                        .frame(width: 40,height: 40)
                                        .foregroundColor(Color("Text"))
                                    
                                }.padding(10)
                            }.padding(.horizontal,10)
                        }
                        .environmentObject(cartmanager)
                        
                    
                    HStack{
                        Text("Total: ")
                            .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .title2))
                        Text("\(cartmanager.total)")
                            .font(.custom("SofiaSans-Black",size: 15,relativeTo: .title2))
                    }
                    
                    
                    Spacer(minLength: 50)
                           
                    NavigationLink(destination: Checkout() , label: {
                        Text("Continuar")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                            .padding()
                            .background(Color("Yellow"))
                            .cornerRadius(30)
                            .foregroundColor(.black)
                    })
                    
                  
                } else {
                    VStack{
                        Text("No tienes ningun articulo en el carrito")
                            .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .body))
                        HStack{
                            Spacer()
                        }
                    }
                    
                }
                HStack{
                    Spacer()
                }
                
            }
            
            
            
         
        }
//        .environmentObject(cartmanager)
        .overlay(
            CartButton()
                .environmentObject(cartmanager)
                .padding()
            
            ,alignment: .bottomTrailing

        )
        .sheet(isPresented: $pagoWompi){
//            SafariWebView(url: "https://baudoap.com")
            Text("HELLOO MOTOOO")
                .presentationDetents([.fraction(0.5)])
        }
        .alert("Resultado de tu compra", isPresented: $showingAlertpayed) {
            // add buttons here
        } message: {
            Text("Tu compra ha sido realizada satisfactoriamente. recibiras un correo de confirmacion.")
        }
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
            .environmentObject(CartManager())
           
    }
}
