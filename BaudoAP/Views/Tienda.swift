//
//  Tienda.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//
import SwiftUI
import SwiftUIMasonry

struct Tienda: View {
    
    @EnvironmentObject var contentProduct: ContentViewModelShop
    
    @EnvironmentObject var cartmanager: CartManager
    
    @EnvironmentObject var alerter: Alerter
    
    @State var selectedOption = "estren"
    
    let impactNotification = UINotificationFeedbackGenerator()
    
    @State private var showFilteredResults = false
    @State private var columnWidth: CGFloat = 0.0
    @State var estrenActive = false
    @State var editorialActive = false
    @State var cositasActive = false
    @State private var isPresentedInfoT = false
    
    @State var isPresentedCompra:Bool = false
    
    var filteredEvents: [Product] {
       if showFilteredResults {
           return contentProduct.postsProducts.filter({$0.type == selectedOption})
       } else {
           return contentProduct.postsProducts
        }
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            VStack{
                HStack{
                    Button {
                        if estrenActive{
                            estrenActive = false
                            showFilteredResults = false
                        } else{
                            showFilteredResults = true
                            selectedOption = "estren"
                            estrenActive = true
                            editorialActive = false
                            cositasActive = false
                        }
                        
                        impactNotification.notificationOccurred(.success)
                    } label: {
                        Text("El estrén")
                    }
                        .font(.custom("SofiaSans-Medium",size: 13,relativeTo: .title2))
                        .padding(.horizontal,20)
                        .padding(.vertical,5)
//                        .foregroundColor(estrenActive ? .black : .white)
                        .foregroundColor(Color("Text"))
                        .background(estrenActive ? Color("Buttons") :  Color("BackgroundCards"))
                        .clipShape(Capsule())
                    Button {
                        if editorialActive {
                            editorialActive = false
                            showFilteredResults = false
                        } else{
                            showFilteredResults = true
                            selectedOption = "editorial"
                            estrenActive = false
                            editorialActive = true
                            cositasActive = false

                        }
                        impactNotification.notificationOccurred(.success)
                    } label: {
                        Text("Editorial")
                    }
                        .font(.custom("SofiaSans-Medium",size: 13,relativeTo: .title2))
                        .padding(.horizontal,25)
                        .padding(.vertical,5)
//                        .foregroundColor(editorialActive ? .black : .white)
                        .foregroundColor(Color("Text"))
                        .background(editorialActive ? Color("Buttons") : Color("BackgroundCards"))
                        .clipShape(Capsule())
                    Button {
                        if cositasActive {
                            cositasActive = false
                            showFilteredResults = false
                        } else{
                            showFilteredResults = true
                            selectedOption = "cositas"
                            estrenActive = false
                            editorialActive = false
                            cositasActive = true
                        }
                        impactNotification.notificationOccurred(.success)
                    } label: {
                        Text("Cositas")
                    }
                        .font(.custom("SofiaSans-Medium",size: 13,relativeTo: .title2))
                        .padding(.horizontal,25)
                        .padding(.vertical,5)
//                        .foregroundColor(cositasActive ? .black : .white)
                        .foregroundColor(Color("Text"))
                        .background(cositasActive ? Color("Buttons") :  Color("BackgroundCards"))
                        .clipShape(Capsule())
                    
                    Button{
                        impactNotification.notificationOccurred(.success)
                        isPresentedInfoT = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25,height: 25, alignment: .trailing)
                            .padding(.leading,15)
                    }
                }
                
                ScrollView{
                    Text("").id("TopToScrollTienda")
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
                    
                    Masonry(.vertical, lines: 2) {
                        //Masonry content
                        
                        ForEach(filteredEvents) { product in
                            NavigationLink(destination: PostCardProductDetail(model: product), label: {
                                PostCardProduct(model: product)
                            } )
                        }
                    }
                    .padding(.horizontal,20)
                }
                .padding(.top,5)

            }
//            .environmentObject(cartmanager)
            .sheet(isPresented: $isPresentedInfoT) {
                InfoViewTienda()
                    .presentationDetents([.fraction(0.7)])
                    .presentationBackground(.black.opacity(0.9))
                    .presentationCornerRadius(20)
            }
            
            NavigationLink(destination: Cart(), label: {
                CartButton()
            })
        }

        .onAppear(){
//            print("Ingrese a Tienda y compruebo i compraRealizada aun esta vacio o no")
            
            Task{
                try await contentProduct.fetchpostsProducts2()
            }
        }
//        .onDisappear(){
//                contentProduct.stopListener()
////              self.isPresentedCompra = false
////              cartmanager.compraRealizada = ""
//        }
                
        .sheet(isPresented: $isPresentedCompra){
            Text("Compra hecha correctamente")
        }
        .alert("Resultado de tu compra", isPresented: $isPresentedCompra) {
            // add buttons here
        } message: {
            Text("Tu compra ha sido realizada satisfactoriamente. recibiras un correo de confirmacion.")
        }
    }
}

struct InfoViewTienda: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            Text("¡Explora nuestra tienda!")
                .foregroundColor(Color("Yellow"))
                .font(.custom("SofiaSans-Medium",size: 20,relativeTo: .title))
                .padding(.bottom,30)
            HStack{
                Text("En Baudó Agencia Pública te invitamos a dejar de ser espectador. Nuestra tienda de productos no es solo una vitrina de artículos, es un portal hacia la transformación. Con cada compra que hagas apoyas nuestro proyecto y haces un voto a favor del periodismo comprometido con las comunidades que buscan ser escuchadas.\n\nÚnete a nosotros, porque en este viaje, la verdadera revolución empieza contigo.")
                    .foregroundColor(.white)
                    .font(.custom("SofiaSans-Medium",size: 18,relativeTo: .title2))
                    .padding(.bottom,20)
                
                    .overlay(Rectangle().frame(maxWidth: .infinity,maxHeight: 1, alignment: .bottom).foregroundColor(Color("AccentColor")), alignment: .bottom)

            }
            .padding(.horizontal,40)
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40,height: 40, alignment: .trailing)
                    .foregroundColor(Color("Buttons"))
            }.padding(.top, 30)
        }
    }
}

struct Tienda_Previews: PreviewProvider {
    static var previews: some View {
        Tienda()
            .environmentObject(CartManager())
    }
}
