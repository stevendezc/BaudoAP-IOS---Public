//
//  PostCardCartProduct.swift
//  BaudoAP
//
//  Created by Codez on 7/06/23.
//

import SwiftUI
import Kingfisher

struct PostCardCartProduct: View {
    
    @EnvironmentObject var cartmanager: CartManager
    
    var model: Product
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
            }
            HStack{
                HStack{
                    KFImage( URL(string: model.thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .frame(width:130)
                        .padding(.bottom,8)
                        .padding(.leading,8)
                    HStack{
                        VStack(alignment: .leading, spacing: 2){
                            
                            Text(model.title)
                                .font(.custom("SofiaSans-Bold", size: 16,relativeTo: .title))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom,5)
                            Text("Precio: \(model.price)")
                                .font(.custom("SofiaSans-Bold", size: 13,relativeTo: .title))
                            Text("Cantidad: \(model.cantidad)")
                                .font(.custom("SofiaSans-Bold", size: 13,relativeTo: .title))
                                .padding(.vertical,5)
                            
                            let cleanedStr = model.price.replacingOccurrences(of: ".", with: "")
                            let priceInt = Int(cleanedStr) ?? 0
                            let totalProd = priceInt * model.cantidad
                            
                            Text("Sub total: $\(totalProd)")
                                .font(.custom("SofiaSans-Medium", size: 13,relativeTo: .title))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal,10)
                                .padding(.vertical,3)
                                .overlay(RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color("Text"), lineWidth: 1))
                            
                            if model.type == "estren"{
                                HStack{
                                    Text("Talla: \(model.tallaFinal)")
                                        .font(.custom("SofiaSans-Regular", size: 15,relativeTo: .title))
//                                        .textCase(.uppercase)
                                    Spacer()
                                }
                            }
                        }
                        
                    }.padding(5)
                }
            }
        }
        .background(Color("BackgroundCards"))
        .cornerRadius(20)
    }
}

struct PostCardCartProduct_Previews: PreviewProvider {
    static var previews: some View {
        PostCardCartProduct(model: Product(title: "Buso Beige", thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBuso-Rio.jpg?alt=media&token=0a1bc3fc-3c66-4dc7-a4d1-efbabec0ffa1&_gl=1*14pxcx4*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkzMDcuMC4wLjA.", size_final: "xs", description: "Esto es una breve description", gallery: ["Array Images"], price: "130.000", type: "estren",subtype: "tshirt", cantidad: 2, stock: 3, tallaFinal: "xs",creation_date: Date(), stock_cenido_xs: 1, stock_cenido_s: 1, stock_cenido_m: 1, stock_cenido_l: 1, stock_cenido_xl: 1 , stock_regular_xs: 1 , stock_regular_s: 1 , stock_regular_m: 1 , stock_regular_l: 1 , stock_regular_xl: 1))
            .environmentObject(CartManager())
    }
}
