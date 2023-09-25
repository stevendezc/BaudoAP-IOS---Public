//
//  PostCardProductDetail.swift
//  BaudoAP
//
//  Created by Codez on 24/03/23.
//

import SwiftUI
import Kingfisher
import Foundation

struct PostCardProductDetail: View {
    
    @EnvironmentObject var cartmanager: CartManager
    //    @StateObject var cartmanager = CartManager()
    @ObservedObject var productsviewmodel = ContentViewModelShop()
    
    let impactNotification = UINotificationFeedbackGenerator()
    
    @State var cantidad:Int = 1
    @State var tallaXs = false
    @State var tallaS = false
    @State var tallaM = false
    @State var tallaL = false
    @State var tallaXL = false
    
    @State var tallaXsCenido = false
    @State var tallaSCenido = false
    @State var tallaMCenido = false
    @State var tallaLCenido = false
    @State var tallaXLCenido = false
    
    @State var tallaXsRegular = false
    @State var tallaSRegular = false
    @State var tallaMRegular = false
    @State var tallaLRegular = false
    @State var tallaXLRegular = false
    
    @State var tallaSel = false
    @State var tallaFinal: String = ""
    
    @State var estiloEscogido = ""
    @State var cenido = false
    @State var regular = false
    @State var cantidadTallaFinal:Int = 0
    @State var showAlert = false
    
    @State var showAlertAddedCart = false
    @State var textTitleAlert = ""
    @State var textAlert = ""
    @State var textButtonAlert = ""
    
    
    var model: Product
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView{
                VStack{
                    VStack{
                        VStack{
                            
                            TabView{
                                ForEach(0..<(model.gallery?.count ?? 0)){ i in
                                    KFImage(URL(string: model.gallery?[i] ?? ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(20)
                                        .padding()
                                }
                            }
                            .frame(minHeight: 550)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                            Spacer()
                        }
                        
                        
                        HStack{
                            Text(model.title)
                                .font(.custom("SofiaSans-Medium", size: 18,relativeTo: .body))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color("Text"))
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                            // .background(RoundedCorners(color: Color("ButtonsProducts"), tl: 0, tr: 10, bl:30, br: 10))
                            
                        }
                    }
                    .padding(10)
                    .cornerRadius(30)
                    VStack{
                        Group{
                            //BASICS
                            VStack(spacing: 15){
                                HStack{
                                    Text("Precio $\(model.price) COP")
                                        .font(.custom("SofiaSans-Black", size: 18,relativeTo: .title))
                                        .fontWeight(.heavy)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack{
                                    Text(model.description)
                                        .font(.custom("SofiaSans-Bold", size: 15,relativeTo: .title))
                                        .fontWeight(.heavy)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        Group{
                            if model.type == "estren"{
                                Group{
                                    Spacer(minLength: 30)
                                    HStack{
                                        Text("Estilo")
                                            .font(.custom("SofiaSans-Bold", size: 15,relativeTo: .title))
                                        Spacer()
                                    }
                                    HStack{
                                        
                                        if model.subtype == "tshirt"{
                                            Button{
                                                impactNotification.notificationOccurred(.success)
                                                estiloEscogido = "cenido"
                                                cenido = true
                                                regular = false
                                                withAnimation(.easeIn(duration: 2000)){
                                                    reader.scrollTo("Cantidadcenido", anchor: .top)
                                                }
                                            } label: {
                                                Text("Ceñido")
                                                    .padding()
                                                    .background(cenido ? Color("Yellow") : Color("BackgroundCards"))
                                                    .cornerRadius(30)
                                                    .foregroundColor(Color("Text"))
                                                    .font(.custom("SofiaSans-Bold", size: 18,relativeTo: .title))
                                            }
                                        }
                                        
                                        Button{
                                            impactNotification.notificationOccurred(.success)
                                            estiloEscogido = "regular"
                                            cenido = false
                                            regular = true
                                            withAnimation(.easeIn(duration: 2000)){
                                                reader.scrollTo("Cantidadregular", anchor: .top)
                                            }
                                        } label: {
                                            Text("Regular")
                                                .padding()
                                                .background(regular ? Color("Yellow") : Color("BackgroundCards"))
                                                .cornerRadius(30)
                                                .foregroundColor(Color("Text"))
                                                .font(.custom("SofiaSans-Bold", size: 18,relativeTo: .title))
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                
                                // Ceñido
                                if estiloEscogido == "cenido"{
                                    Group{
                                        VStack{
                                            HStack{
                                                Text("Tallas disponibles").id("Cantidadcenido")
                                                    .font(.custom("SofiaSans-Bold", size: 15,relativeTo: .title))
                                                Spacer()
                                            }
                                            HStack{
                                                
                                                if model.stock_cenido_xs > 0{
                                                    Button{
                                                        cantidad = 1
                                                        tallaXsCenido = true
                                                        tallaSCenido = false
                                                        tallaMCenido = false
                                                        tallaLCenido = false
                                                        tallaXLCenido = false
                                                        
                                                        self.tallaFinal = "xs-Cenido"
                                                        cantidadTallaFinal = self.model.stock_cenido_xs
                                                        
                                                        
                                                    }label:{
                                                        Text("XS")
                                                            .padding(.horizontal,5)
                                                            .padding(.vertical,5)
                                                            .background(tallaXsCenido ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5)
                                                        //                                                    Text("\(model.stock_cenido_xs)")
                                                        //                                                        .foregroundColor(.white)
                                                    }
                                                }
                                                
                                                if model.stock_cenido_s > 0{
                                                    Button{
                                                        impactNotification.notificationOccurred(.success)
                                                        cantidad = 1
                                                        tallaXsCenido = false
                                                        tallaSCenido = true
                                                        tallaMCenido = false
                                                        tallaLCenido = false
                                                        tallaXLCenido = false
                                                        self.tallaFinal = "s-Cenido"
                                                        cantidadTallaFinal = self.model.stock_cenido_s
                                                        
                                                        
                                                    }label:{
                                                        Text("S")
                                                            .padding(.horizontal,10)
                                                            .padding(.vertical,5)
                                                            .background(tallaSCenido ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5)
                                                        //                                                    Text("\(model.stock_cenido_s)")
                                                        //                                                        .foregroundColor(.white)
                                                    }
                                                }
                                                
                                                if model.stock_cenido_m > 0{
                                                    Button{
                                                        impactNotification.notificationOccurred(.success)
                                                        cantidad = 1
                                                        tallaXsCenido = false
                                                        tallaSCenido = false
                                                        tallaMCenido = true
                                                        tallaLCenido = false
                                                        tallaXLCenido = false
                                                        
                                                        self.tallaFinal = "m-Cenido"
                                                        cantidadTallaFinal = self.model.stock_cenido_m
                                                        
                                                    }label:{
                                                        
                                                        Text("M")
                                                            .padding(.horizontal,10)
                                                            .padding(.vertical,5)
                                                            .background(tallaMCenido ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5)
                                                        //                                                    Text("\(model.stock_cenido_m)")
                                                        //                                                        .foregroundColor(.white)
                                                    }
                                                }
                                                
                                                if model.stock_cenido_l > 0{
                                                    Button{
                                                        impactNotification.notificationOccurred(.success)
                                                        cantidad = 1
                                                        tallaXsCenido = false
                                                        tallaSCenido = false
                                                        tallaMCenido = false
                                                        tallaLCenido = true
                                                        tallaXLCenido = false
                                                        
                                                        self.tallaFinal = "l-Cenido"
                                                        cantidadTallaFinal = self.model.stock_cenido_l
                                                        
                                                    }label:{
                                                        
                                                        Text("L")
                                                            .padding(.horizontal,10)
                                                            .padding(.vertical,5)
                                                            .background(tallaLCenido ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5)
                                                        //                                                    Text("\(model.stock_cenido_l)")
                                                        //                                                        .foregroundColor(.white)
                                                    }
                                                }
                                                if model.stock_cenido_xl > 0{
                                                    Button{
                                                        impactNotification.notificationOccurred(.success)
                                                        cantidad = 1
                                                        tallaXsCenido = false
                                                        tallaSCenido = false
                                                        tallaMCenido = false
                                                        tallaLCenido = false
                                                        tallaXLCenido = true
                                                        
                                                        self.tallaFinal = "xl-Cenido"
                                                        cantidadTallaFinal = self.model.stock_cenido_xl
                                                        
                                                    }label:{
                                                        
                                                        Text("XL")
                                                            .padding(.horizontal,10)
                                                            .padding(.vertical,5)
                                                            .background(tallaXLCenido ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5)
                                                        //                                                    Text("\(model.stock_cenido_xl)")
                                                        //                                                        .foregroundColor(.white)
                                                        
                                                    }
                                                }
                                                Spacer()
                                            }
                                            
                                            .foregroundColor(.black)
                                            
                                            
                                        }
                                    }
                                    
                                }
                                else if estiloEscogido == "regular"{
                                    Group{
                                        HStack{
                                            VStack{
                                                HStack{
                                                    Text("Tallas disponibles").id("Cantidadregular")
                                                        .font(.custom("SofiaSans-Bold", size: 15,relativeTo: .title))
                                                    Spacer()
                                                }
                                                HStack{
                                                    if model.stock_regular_xs > 0{
                                                        Button{
                                                            impactNotification.notificationOccurred(.success)
                                                            cantidad = 1
                                                            tallaXsRegular = true
                                                            tallaSRegular = false
                                                            tallaMRegular = false
                                                            tallaLRegular = false
                                                            tallaXLRegular = false
                                                            
                                                            self.tallaFinal = "xs-Regular"
                                                            cantidadTallaFinal = self.model.stock_regular_xs
                                                            
                                                            
                                                        }label:{
                                                            Text("XS")
                                                                .padding(.horizontal,5)
                                                                .padding(.vertical,5)
                                                                .background(tallaXsRegular ? Color("Yellow") : Color("ButtonsProducts"))
                                                                .cornerRadius(5)
                                                        }
                                                    }
                                                    
                                                    if model.stock_regular_s > 0{
                                                        Button{
                                                            impactNotification.notificationOccurred(.success)
                                                            cantidad = 1
                                                            tallaXsRegular = false
                                                            tallaSRegular = true
                                                            tallaMRegular = false
                                                            tallaLRegular = false
                                                            tallaXLRegular = false
                                                            self.tallaFinal = "s-Regular"
                                                            cantidadTallaFinal = self.model.stock_regular_s
                                                            
                                                            
                                                        }label:{
                                                            Text("S")
                                                                .padding(.horizontal,10)
                                                                .padding(.vertical,5)
                                                                .background(tallaSRegular ? Color("Yellow") : Color("ButtonsProducts"))
                                                                .cornerRadius(5)
                                                        }
                                                    }
                                                    
                                                    if model.stock_regular_m > 0{
                                                        Button{
                                                            impactNotification.notificationOccurred(.success)
                                                            cantidad = 1
                                                            tallaXsRegular = false
                                                            tallaSRegular = false
                                                            tallaMRegular = true
                                                            tallaLRegular = false
                                                            tallaXLRegular = false
                                                            
                                                            self.tallaFinal = "m-Regular"
                                                            cantidadTallaFinal = self.model.stock_regular_m
                                                            
                                                        }label:{
                                                            Text("M")
                                                                .padding(.horizontal,10)
                                                                .padding(.vertical,5)
                                                                .background(tallaMRegular ? Color("Yellow") : Color("ButtonsProducts"))
                                                                .cornerRadius(5)
                                                        }
                                                    }
                                                    
                                                    if model.stock_regular_l > 0{
                                                        Button{
                                                            impactNotification.notificationOccurred(.success)
                                                            cantidad = 1
                                                            tallaXsRegular = false
                                                            tallaSRegular = false
                                                            tallaMRegular = false
                                                            tallaLRegular = true
                                                            tallaXLRegular = false
                                                            
                                                            self.tallaFinal = "l-Regular"
                                                            cantidadTallaFinal = self.model.stock_regular_l
                                                            
                                                        }label:{
                                                            Text("L")
                                                                .padding(.horizontal,10)
                                                                .padding(.vertical,5)
                                                                .background(tallaLRegular ? Color("Yellow") : Color("ButtonsProducts"))
                                                                .cornerRadius(5)
                                                        }
                                                    }
                                                    if model.stock_regular_xl > 0{
                                                        Button{
                                                            impactNotification.notificationOccurred(.success)
                                                            cantidad = 1
                                                            tallaXsRegular = false
                                                            tallaSRegular = false
                                                            tallaMRegular = false
                                                            tallaLRegular = false
                                                            tallaXLRegular = true
                                                            
                                                            self.tallaFinal = "xl-Regular"
                                                            cantidadTallaFinal = self.model.stock_regular_xl
                                                            
                                                        }label:{
                                                            Text("XL")
                                                                .padding(.horizontal,10)
                                                                .padding(.vertical,5)
                                                                .background(tallaXLRegular ? Color("Yellow") : Color("ButtonsProducts"))
                                                            .cornerRadius(5) }
                                                    }
                                                    Spacer()
                                                }
                                                
                                                .foregroundColor(.black)
                                            }
                                            
                                        }//FIN HStack
                                    }
                                }
                                
                                //CANTIDAD BUTTONS
                                Group{
                                    VStack(alignment:.leading){
                                        VStack{
                                            Spacer(minLength: 20)
                                            HStack{
                                                Text("Cantidad").padding(.leading,10)
                                                Spacer()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            // Buttons plus and minus for quantity
                                            
                                            HStack{
                                                Button{
                                                    if cantidad > 1 {
                                                        cantidad -= 1
                                                        impactNotification.notificationOccurred(.success)
                                                    }
                                                }label: {
                                                    Image(systemName: "minus")
                                                        .padding(.vertical,17)
                                                        .padding(.horizontal,10)
                                                        .background(Color.gray.opacity(0.4))
                                                        .cornerRadius(50)
                                                }
                                                Text("\(cantidad)")
                                                    .padding(10)
                                                Button{
                                                    if cantidad >= 1 && cantidad < 10 && cantidad < cantidadTallaFinal {
                                                        impactNotification.notificationOccurred(.success)
                                                        cantidad += 1
                                                    }
                                                }label: {
                                                    Image(systemName: "plus")
                                                        .padding(.vertical,10)
                                                        .padding(.horizontal,10)
                                                        .background(Color.gray.opacity(0.7))
                                                        .cornerRadius(50)
                                                }
                                                
                                            }
                                            //                .frame(width:100)
                                            .foregroundColor(.black)
                                            .padding(.horizontal,20)
                                            .padding(.vertical,10)
                                            .background(Color("ButtonsProducts").opacity(1))
                                            .cornerRadius(50)
                                        }//FIN VStack
                                    }//Fin VStack
                                }
                                
                                //Button comprar
                                HStack{
                                    Spacer()
                                    Button{
                                        if tallaFinal != "" {
                                            impactNotification.notificationOccurred(.success)
                                            cartmanager.addProduct(product: model, cantidad: cantidad, size_final: tallaFinal)
                                            
                                            self.textTitleAlert = "¡Que bien!"
                                            self.textAlert = "Tu producto **\(model.title)**, se ha agregado exitosamente al carrito de compras."
                                            self.textButtonAlert = "Continuar"
                                            
                                            self.showAlert = true
                                            
                                        } else {
                                            self.textTitleAlert = "UPS"
                                            self.textAlert = "Selecciona estilo y talla para continuar"
                                            self.textButtonAlert = "Ok"
                                            
                                            self.showAlert = true
                                            withAnimation(.easeIn(duration: 2000)){
                                                reader.scrollTo("Cantidadcenido", anchor: .top)
                                            }
                                        }
                                        
                                    } label: {
                                        Text("Agregar a carrito")
                                            .padding(25)
                                            .background(tallaFinal != "" ? Color("Yellow") : Color.gray)
                                            .cornerRadius(30)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                                .padding(.top,30)
                                .padding(.bottom,50)
                            } else {
                                //CANTIDAD BUTTONS
                                VStack(alignment:.leading){
                                    VStack{
                                        Spacer(minLength: 30)
                                        HStack{
                                            Text("Cantidad").padding(.leading,10)
                                            Spacer()
                                        }
                                    }
                                    VStack(alignment: .leading){
                                        // Buttons plus and minus for quantity
                                        
                                        HStack{
                                            Button{
                                                if cantidad > 1 {
                                                    impactNotification.notificationOccurred(.success)
                                                    cantidad -= 1
                                                }
                                            }label: {
                                                Image(systemName: "minus")
                                                    .padding(.vertical,17)
                                                    .padding(.horizontal,10)
                                                    .background(Color.gray.opacity(0.5))
                                                    .cornerRadius(50)
                                            }
                                            Text("\(cantidad)")
                                                .padding(10)
                                            Button{
                                                if cantidad >= 1 && cantidad < model.stock  {
                                                    impactNotification.notificationOccurred(.success)
                                                    cantidad += 1
                                                }
                                                
                                            }label: {
                                                Image(systemName: "plus")
                                                    .padding(.vertical,10)
                                                    .padding(.horizontal,10)
                                                    .background(Color.gray.opacity(1))
                                                    .cornerRadius(50)
                                            }
                                        }
                                        .foregroundColor(.black)
                                        .padding(.horizontal,20)
                                        .padding(.vertical,10)
                                        .background(Color("ButtonsProducts").opacity(0.5))
                                        .cornerRadius(50)
                                    }//FIN VStack
                                }//Fin VStack
                                HStack{
                                    Spacer()
                                    Button{
                                        cartmanager.addProduct(product: model, cantidad: cantidad, size_final: tallaFinal)
                                        impactNotification.notificationOccurred(.success)
                                        
                                        self.textTitleAlert = "¡Que bien!"
                                        self.textAlert = "Tu producto **\(model.title)**, se ha agregado exitosamente al carrito de compras."
                                        self.textButtonAlert = "Continuar"
                                        
                                        self.showAlert = true
                                    } label: {
                                        Text("Agregar a carrito")
                                            .padding(25)
                                            .background(Color("Yellow"))
                                            .cornerRadius(30)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                }
                                .padding(.top,30)
                                .padding(.bottom,50)
                            }
                        }
                    }
                    .padding(.horizontal,30)
                }//FIN SCROLLREADER
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(self.textTitleAlert), message: Text(self.textAlert), dismissButton: .default(Text("Ok")))
                }
            }
            
            
            .overlay(
                NavigationLink(destination: Cart(), label: {
                    CartButton()
                })
                .padding(.trailing,10)
                ,alignment: .bottomTrailing
            )
            
            
        }
    }
}

struct PostCardProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        PostCardProductDetail(model: Product(title: "Buso Beige", thumbnail: "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBuso-Rio.jpg?alt=media&token=0a1bc3fc-3c66-4dc7-a4d1-efbabec0ffa1&_gl=1*14pxcx4*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkzMDcuMC4wLjA.", size_final: "L", description: "Esto es una breve description", gallery: ["https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBusoverd.png?alt=media&token=f96cc75d-a909-4ae0-9313-3f569139694c", "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FFotolibro%20-%20Tierra%20Prometida.jpg?alt=media&token=8f37b9da-9ef0-46a8-836e-6721572f24aa&_gl=1*14pan3q*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkzNDkuMC4wLjA.", "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBuso-Navegante.jpg?alt=media&token=d4612292-1471-4f7e-b315-9aeecfdac7c4&_gl=1*1w3msrs*_ga*MTI1ODc4NDM2MC4xNjc2Mjk5OTAy*_ga_CW55HF8NVT*MTY4NTcyOTA0Ni41Mi4xLjE2ODU3MjkyNjguMC4wLjA.", "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FRecurso%2022%402x-8%202.png?alt=media&token=4bfaaf52-4a6c-4e3e-8823-77f2b6c98bfc", "https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Products%2FBusoverd.png?alt=media&token=f96cc75d-a909-4ae0-9313-3f569139694c"], price: "130.000", type: "estren",subtype: "tshirt", cantidad: 2, stock: 3, tallaFinal: "L",creation_date: Date(), stock_cenido_xs: 1, stock_cenido_s: 1, stock_cenido_m: 1, stock_cenido_l: 1, stock_cenido_xl: 1 , stock_regular_xs: 1 , stock_regular_s: 1 , stock_regular_m: 1 , stock_regular_l: 1 , stock_regular_xl: 1))
            .environmentObject(CartManager())
        
    }
}
