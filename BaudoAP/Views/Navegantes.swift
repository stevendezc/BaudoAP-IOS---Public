//
//  Navegantes.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI

struct Navegantes: View {
    @Environment(\.openURL) var openURL
    
    @State private var aporte_mensual: Bool = false
    @State private var aporte_anual: Bool = false
    @State private var aporte_libre: Bool = false
    @State private var monto: String = ""
    @State var AlertPresent = false
    
    
    @State private var showWebViewaporte_mensual = false
    @State private var showWebViewaporte_anual = false
    @State private var showWebViewaporte_libre = false
    
    @State private var isPresentedInfoN = false
    
    @StateObject var userservice = UserSettings()
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("").id("TopToScrollNavegantes")
                HStack{
                    Spacer()
                    
                    Button{
                        isPresentedInfoN = true
                    } label:{
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25,height: 25, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.bottom,10)
                    }
                }
                Group{
                    //FIRST CARD
                    Group{
                        VStack{
                            ZStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Spacer()
                                    }
                                    
                                    HStack(){
                                        
                                        Button {
                                            
                                            openURL(URL(string: userservice.aporte_mensual)!)
                                        } label: {
                                            VStack{
                                                Text("Aporte mensual").font(.custom("SofiaSans-Bold",size: 20,relativeTo: .caption)).foregroundColor(.black)
                                                Text("$15.000 cop").font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body)).foregroundColor(.black)
                                                
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal,10)
                                        .padding(.vertical)
                                        .background(Color("NavBlue"))
                                        .cornerRadius(70)
                                        
                                    }
                                }.padding(10)
                                
                            }
                            .background(Color("BackgroundCardsNavLight"))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Beneficios \n\n- Recibe nuestro paquete de stickers y diseños digitales para tu celular y fondos de pantalla para tu computador con nuestras ilustraciones.")
                                .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                .foregroundColor(Color("Text"))
                                .padding(.horizontal,20)
                            
                            Button{
                                self.aporte_mensual.toggle()
                                
                            }label: {
                                Text("Más información")
                                    .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                    .foregroundColor(Color("Text"))
                                    .padding(5)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                                
                                
                            }
                            
                            if aporte_mensual {
                                Text("""
                                    - Recibe la información de nuestras coberturas de periodismo independiente antes que cualquier persona. Las historias que cubrimos son sobre medio ambiente, género e inclusión y memoria, paz y conflicto.\n\n- Recibe una guía imperdible con recomendaciones prácticas para ser responsable día a día con el medio ambiente.\n\n* Duración de beneficios 1 año, con débito automático y posibilidad de renovación.\n\nGracias a ti la información valiosa e independiente seguirá circulando.
                                    
                                    """)
                                .padding(.top,5)
                                .padding(.horizontal,20)
                                .font(.custom("SofiaSans-Light",size: 15,relativeTo: .body))
                                .foregroundColor(Color("Text"))
                            }
                            
                            
                            Spacer(minLength: 20)
                            
                        }
                        .background(Color("BackgroundCardsNavDark"))
                        .cornerRadius(20)
                    }
                    .padding(.top,0)
                    .padding(.bottom,20)
                    
                    
                    //SECOND CARD
                    Group{
                        VStack{
                            ZStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Spacer()
                                    }

                                    HStack{
                                        Button {
                                            openURL(URL(string: userservice.aporte_anual)!)
                                        } label: {
                                            HStack{
                                                VStack{
                                                    Text("Aporte anual").font(.custom("SofiaSans-Bold",size: 20,relativeTo: .caption)).foregroundColor(.black)
                                                    Text("$150.000 cop").font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body)).foregroundColor(.black)
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal,10)
                                        .padding(.vertical)
                                        .background(Color("ComuTur"))
                                        .cornerRadius(70)
                                        
                                    }
                                }.padding(10)
                                
                            }
                            .background(Color("BackgroundCardsNavLight"))
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Beneficios:\n\n- Recibe nuestro paquete de stickers y diseños digitales para tu celular y fondos de pantalla para tu computador con nuestras ilustraciones.")
                                .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                .foregroundColor(Color("Text"))
                                .padding(.horizontal,20)
                            
                            Button{
                                aporte_anual.toggle()
                            }label: {
                                Text("Más información")
                                    .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                    .foregroundColor(Color("Text"))
                                    .padding(5)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                            }
                            
                            if aporte_anual {
                                Text("""
                                    - Recibe la información de nuestras coberturas de periodismo independiente antes que cualquier persona. Las historias que cubrimos son sobre medio ambiente, género e inclusión y memoria, paz y conflicto.\n\n- Recibe una guía imperdible con recomendaciones prácticas para ser responsable día a día con el medio ambiente.\n\n- Accede a un descuento exclusivo del 15% en fotolibros de nuestra tienda.\n\n- Accede a nuestros eventos virtuales de manera gratuita, te avisaremos antes para que estés en primera fila.\n\n-Recibirás una invitación a un café virtual con el equipo de BaudóAp.\n\nSi quieres que tu aporte sea certificado por nuestra fundación envía tu comprobante a baudo.ap@gmail.com.\n\n* Duración de beneficios 1 año con renovación automática y posibilidad de cancelación.\n\nGracias a ti la información valiosa e independiente seguirá circulando.
                                    """)
//                                .padding(.top,5)
                                .padding(.horizontal,20)
                                .font(.custom("SofiaSans-Light",size: 15,relativeTo: .body))
                                .foregroundColor(Color("Text"))
                            }
                            Spacer(minLength: 20)
                        }
                        .background(Color("BackgroundCardsNavDark"))
                        .cornerRadius(20)
                    }
                    .padding(.bottom,20)
                    
                    
                    //FOUR CARD
                    Group{
                        VStack{
                            ZStack{
                                VStack(alignment: .leading){
                                    HStack{
                                        Spacer()
                                    }

                                    HStack{
                                        Button {
                                            
                                            openURL(URL(string: userservice.aporte_libre)!)
                                        } label: {
                                            VStack{
                                                Text("Aporte libre")
                                                    .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .body))
                                                    .foregroundColor(.black)
                                                Text("Aporte único de monto libre")
                                                    .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal,30)
                                        .padding(.vertical)
                                        .background(Color("ComuPro"))
                                        .cornerRadius(70)
                                    }
                                }.padding(10)
                            }
                            .background(Color("BackgroundCardsNavLight"))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .cornerRadius(20)
                            
                            Text("Beneficios\n\nNo tienes ninguna restricción. Puedes donar lo que quieras y tendrás la seguridad de aportar a que BaudoAP siga siendo independiente y que más gente como tú conozca a profundidad y de forma innovadora los temas de derechos humanos en Colombia y América Latina.")
                                .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                .foregroundColor(Color("Text"))
                                .padding(.horizontal,20)
                            
                            Button{
                                aporte_libre.toggle()
                            }label: {
                                Text("Más información")
                                    .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                    .foregroundColor(Color("Text"))
                                    .padding(5)
                                    .background(.thinMaterial)
                                    .cornerRadius(20)
                            }
                            
                            if aporte_libre {
                                Text("Si quieres que tu aporte sea certificado por nuestra fundación envía tu comprobante a baudo.ap@gmail.com.")
                                    .padding(.top,5)
                                    .padding(.horizontal,20)
                                    .font(.custom("SofiaSans-Light",size: 15,relativeTo: .body))
                                    .foregroundColor(Color("Text"))
                            }
                            
                            
                            Spacer(minLength: 20)
                        }
                    }
                    .background(Color("BackgroundCardsNavDark"))
                    .cornerRadius(20)
                    
                    Spacer(minLength: 20)
                    
                    Image("Navegantes")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                    
                    Spacer(minLength: 30)
                    
                }.padding(.horizontal,20)
                
            }
            
            .sheet(isPresented: $showWebViewaporte_mensual){
                SafariWebView(url: userservice.aporte_mensual)
            }
            
            .sheet(isPresented: $showWebViewaporte_anual){
                SafariWebView(url: userservice.aporte_anual)
            }
            
            .sheet(isPresented: $showWebViewaporte_libre){
                SafariWebView(url: userservice.aporte_libre)
            }
            
        }
        
        .alert("Resultado de tu compra", isPresented: $AlertPresent) {
            // add buttons here
        } message: {
            Text("Tu compra ha sido realizada satisfactoriamente. recibiras un correo de confirmacion.")
        }
        
        .sheet(isPresented: $isPresentedInfoN) {
            InfoViewNavegantes()
                .presentationDetents([.fraction(0.6)])
                .presentationBackground(.black.opacity(0.9))
                .presentationCornerRadius(20)
        }
        
    }
    
}

struct InfoViewNavegantes: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Ser navegante es asumirse como transformador social, siendo parte de una comunidad digital que cree en el periodismo independiente y contribuye activamente para su desarrollo y difusión.\n En esta sección puedes hacerte navegante y realizar una donación que apoye nuestro trabajo.")
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

struct Navegantes_Previews: PreviewProvider {
    static var previews: some View {
        Navegantes()
    }
}



