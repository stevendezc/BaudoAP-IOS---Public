//
//  PostCardProduct.swift
//  BaudoAP
//
//  Created by Codez on 24/03/23.
//

import SwiftUI
import Kingfisher


struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}


struct PostCardProduct: View {

    @EnvironmentObject var cartmanager: CartManager
    
    var model: Product
    
    var body: some View {
    
        VStack {
            
            ZStack(alignment: .bottom){
                KFImage(URL(string: model.thumbnail))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    //                .border(Color.red, width: 3)
                    HStack{
                        Text(model.title)
                            .font(.custom("SofiaSans-Medium", size: 13,relativeTo: .body))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("Text"))
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(.ultraThinMaterial.opacity(0.5))
                            .cornerRadius(20)
                           // .background(RoundedCorners(color: Color("ButtonsProducts"), tl: 0, tr: 10, bl:30, br: 10))
                        
                    }.padding(.bottom,5)

            }
//            Spacer()
        }
            
//            .padding(15)
//            .background(Color("BackgroundCards"))
        
//        Spacer()
    }
}

struct PostCardProduct_Previews: PreviewProvider {
    static var previews: some View {
        
        PostCardProduct(model: Product(title: "Buso Beige", thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBuso-Rio.jpg?alt=media&token=0a1bc3fc-3c66-4dc7-a4d1-efbabec0ffa1&_gl=1*14pxcx4*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkzMDcuMC4wLjA.", size_final: "L", description: "Esto es una breve description", gallery: ["Array Images"], price: "130.000", type: "estren",subtype: "tshirt", cantidad: 2, stock: 3, tallaFinal: "L",creation_date: Date(), stock_cenido_xs: 1, stock_cenido_s: 1, stock_cenido_m: 1, stock_cenido_l: 1, stock_cenido_xl: 1 , stock_regular_xs: 1 , stock_regular_s: 1 , stock_regular_m: 1 , stock_regular_l: 1 , stock_regular_xl: 1))
            .environmentObject(CartManager())
        
    }
}



