//
//  PaymentMethodCard.swift
//  BaudoAP
//
//  Created by Codez Studio on 13/07/23.
//

import SwiftUI

struct PaymentMethodCard: View {
    
    @State var nombreCard: String = ""
    @State var numeroCard: String = ""
    @State var fechaExpMes: String = ""
    @State var fechaExpAno: String = ""
    @State var CVC: String = ""
    
    
    
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text("Ingresa los datos de tu tarjeta")
                        .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
                        .padding(20)
                        .foregroundColor(Color("Text"))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Group {
                    Text("Nombre del titular de la tarjeta")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("Nombre en la tarjeta", text: $nombreCard)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                }
                
                Group {
                    Text("Numero de la tarjeta ")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("5333 5552 5445 5554", text: $numeroCard)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                }
                
                Group {
                    Text("Fecha de expiracion")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    
                    HStack{
                        VStack{
                            Text("Mes")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                            TextField("5", text: $fechaExpMes)
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding()
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                        }
                        VStack{
                            Text("Año")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                            TextField("2023", text: $fechaExpAno)
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding()
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                        }
                        
                    }.frame(width: 200)
                    
                }
                Group {
                    Text("CVC")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("354", text: $CVC)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                        .frame(width: 100)
                }
                
                Button{
                    print("He ingresado mis datos de tarjeta de credito")
                } label: {
                    HStack{
                        Spacer()
                        Text("Continuar")
                            .padding(20)
                            .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
                        Spacer()
                    }
                    .padding()
                    
                }
            }
            .padding()
        }
    }
}

struct PaymentMethodCard_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodCard()
    }
}
