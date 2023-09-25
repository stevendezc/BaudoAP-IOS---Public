//
//  PostCardProduct.swift
//  BaudoAP
//
//  Created by Codez on 24/03/23.
//

import SwiftUI
import Kingfisher



struct PostCardCart: View {
    
    var model: Product
    
    var body: some View {
    
        VStack {
            
            HStack{
                KFImage( URL(string: model.thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .frame(width:150)
                    //                .border(Color.red, width: 3)
                    HStack{
                        Text(model.title)
                            .font(.custom("SofiaSans-Medium", size: 13,relativeTo: .body))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(RoundedCorners(color: Color("ButtonsProducts"), tl: 0, tr: 10, bl:30, br: 10))
                        
                        
                        
                        Spacer()
                    }

            }
            Spacer()
        }
            
//            .padding(15)
//            .background(Color("BackgroundCards"))
        
        Spacer()
    }
}

struct PostCardCart_Previews: PreviewProvider {
    static var previews: some View {
        
        PostCardCart(model: Product(title: "Buso Beige", thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBuso-Rio.jpg?alt=media&token=0a1bc3fc-3c66-4dc7-a4d1-efbabec0ffa1&_gl=1*14pxcx4*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkzMDcuMC4wLjA.", size_final: "L", description: "Esto es una breve description", gallery: ["Array Images"], price: "130.000", type: "estren",subtype: "hoodie", cantidad: 2,stock: 3, tallaFinal: "L",creation_date: Date(), stock_cenido_xs: 1, stock_cenido_s: 1, stock_cenido_m: 1, stock_cenido_l: 1, stock_cenido_xl: 1 , stock_regular_xs: 1 , stock_regular_s: 1 , stock_regular_m: 1 , stock_regular_l: 1 , stock_regular_xl: 1))
    }
}



