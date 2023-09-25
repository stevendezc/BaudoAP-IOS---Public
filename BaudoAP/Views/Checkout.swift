//
//  Checkout.swift
//  BaudoAP
//
//  Created by Codez on 2/06/23.
//

import SwiftUI


struct Checkout: View {
    
    @State private var correo = ""
    @State private var nombre = ""
    @State private var documento = ""
    @State private var pais = ""
    @State private var departamento = ""
    @State private var ciudad = ""
    @State private var direccion = ""
    @State private var telefono = ""
    @State var ResultPago = ""
    @State var MensajeDeAlerta = ""
    
    @State private var selectedPais = "colombia"
        let paises = ["Colombia"]
    
    @State var pagoWompi = false
    @State var triggerAlertCheckout = false
    @State var showingAlertpayed = false
    @State var showingAlertpayed2 = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartmanager: CartManager
    @ObservedObject var viewModel = AuthViewModel()
    
    
    @State var id: UUID = UUID()
    
    
    struct dataResponse: Decodable{
        let data: [dataInside]
    }
    
    struct dataInside: Codable{
        let amount_in_cents: Int
        let created_at: String
        let status: String
    }
    
    
    var isLoginFormValid:Bool {
        !correo.isEmpty && correo.contains("@") && !nombre.isEmpty && !documento.isEmpty && !ciudad.isEmpty && !direccion.isEmpty && !telefono.isEmpty
    }
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Text("Informacion \npara el envio").font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
                    
                    VStack(alignment: .leading){
                        
                        Group {
                            Text("Correo")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding(.leading,10)
                                .foregroundColor(Color("Yellow"))
                            TextField("Correo", text: $correo)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            if !self.correo.contains("@") && triggerAlertCheckout{
                                Text("Debes ingresar un correo valido")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("Nombre").font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2)).padding(.leading,10).foregroundColor(Color("Yellow"))
                            
                            TextField("nombre", text: $nombre)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            
                            if self.nombre.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar tu nombre")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("Documento de identidad")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding(.leading,10)
                                .foregroundColor(Color("Yellow"))
                            TextField("Documento", text: $documento)
                            
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            
                            if self.documento.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar tu numero de identificacion")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("País")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding(.leading,10)
                                .foregroundColor(Color("Yellow"))
                            Picker("Pais", selection: $selectedPais) {
                                ForEach(paises, id: \.self) {
                                    Text($0)
                                }
                            }
                                .pickerStyle(.wheel)
                            Text("Departamento")
                                .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                                .padding(.leading,10)
                                .foregroundColor(Color("Yellow"))
                            TextField("Departamento", text: $departamento)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            if self.departamento.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar tu departamento")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("Ciudad").font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2)).padding(.leading,10).foregroundColor(Color("Yellow"))
                            TextField("Ciudad", text: $ciudad)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            if self.ciudad.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar tu ciudad")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("Direccion").font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2)).padding(.leading,10).foregroundColor(Color("Yellow"))
                            TextField("Direccion", text: $direccion)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            if self.direccion.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar tu dirección")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            Text("Telefono").font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2)).padding(.leading,10).foregroundColor(Color("Yellow"))
                            TextField("Telefono", text: $telefono)
//                                .keyboardType(.numberPad)
                                .padding()
                                .foregroundColor(Color("Text"))
                                .textFieldStyle(.plain)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                            if self.telefono.isEmpty && triggerAlertCheckout{
                                Text("Debes ingresar un numero celular")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group {
                            HStack(alignment: .center){
                                Spacer()
                                Button {
                                    
                                    if isLoginFormValid {
                                        pagoWompi.toggle()
                                        
                                    } else {
                                        triggerAlertCheckout = true
                                    }
                                    
                                }label:{
                                    Text("Continuar")
                                        .font(.custom("SofiaSans-Bold",size: 18,relativeTo: .caption))
                                        .padding(30)
                                        .overlay(RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color("Yellow"), lineWidth: 2))
                                        .foregroundColor(isLoginFormValid ? Color("Text") : Color.gray)
                                        .background(isLoginFormValid ? Color("Yellow") : Color.gray.opacity(0.0))
                                        .cornerRadius(40)
                                }
                                Spacer()
                            }
                        }
//                        .padding(.top,30)
                        .padding(.horizontal,20)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal,20)
            }// FIN SCROLLVIEW
        }//FIN NAVIGATIONVIEW
        .onAppear{
            viewModel.fetchUser()
        }
        
        .fullScreenCover(isPresented: $pagoWompi){
            //            SafariWebView(url: "https://baudoap.com")
            ZStack(alignment: .topTrailing){
                
//                NavegadorWeb(url: "https://checkout.wompi.co/p/?public-key=pub_test_16jNk5Ea0ME5n2j1RLnOo28t0f1Fia0m&currency=COP&amount-in-cents=\(cartmanager.total)00&reference=\(id)&redirect-url=https%3A%2F%2Fbaudoap.com%2Fagradecimiento&customer-data%3Aemail=\(self.correo)&customer-data%3Afull-name=\(self.nombre)&customer-data%3Aphone-number=\(self.telefono)&customer-data%3Alegal-id=\(self.documento)&customer-data%3Alegal-id-type=CC")
                
                
                let newName = nombre.replacingOccurrences(of: " ", with: "")
                let newCorreo = correo.replacingOccurrences(of: " ", with: "")
                let newTelefono = telefono.replacingOccurrences(of: " ", with: "")
                let newDocumento = documento.replacingOccurrences(of: " ", with: "")
                
                NavegadorWeb(url: "https://checkout.wompi.co/p/?public-key=pub_prod_wJ37gyrCWBkVGTLS5B90ssFRnfVfB7hO&currency=COP&amount-in-cents=\(cartmanager.total)00&reference=\(id)&redirect-url=https://baudoap.com/agradecimiento&customer-data%3Aemail=\(newCorreo)&customer-data%3Afull-name=\(newName)&customer-data%3Aphone-number=\(newTelefono)&customer-data%3Alegal-id=\(newDocumento)&customer-data%3Alegal-id-type=CC")
                
                // CC, CE, NIT, PP, TI, DNI, RG, OTHER
                
                Button{
                    Task{
                        await WompiCallGetLink()
                    }
                    dismiss()

                } label:{
                    Text("Cerrar")
                        .padding(5)
                        .padding(.horizontal,10)
                        .background(Color("Yellow"))
                        .cornerRadius(15)
                        .foregroundColor(.black)
                        .padding(5)
                        .padding(.top,50)
                }
            }
            
            .ignoresSafeArea()
        }
    }// FIN BODY
    
       
    
   @MainActor
    func WompiCallGetLink() async {
        //    let baseURL = "https://api.wompi.co/v1"
        //    let endpoint = "/transactions"
        //    0let url = URL(string: "https://sandbox.wompi.co/v1/payment_links")!
        //    let url = URL(string: "https://sandbox.wompi.co/v1/payment_links/test_OkIrhJ")!
        
        struct ResultTransaction: Codable {
            var status: String
        }
        
        //pub_prod_wJ37gyrCWBkVGTLS5B90ssFRnfVfB7hO
        
        let url = URL(string: "https://production.wompi.co/v1/transactions?reference=\(id)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer prv_prod_IuiRQeJcWSlX1kUEUTOQJYzZ51uJJ681", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    // Error occurred while making the API request
                    print("ERROR EN EL URLSession",error)
                    
                } else if let data = data {
                    // Handle the API response data
                    do {
                        // Process the response JSON
                        let decoder = JSONDecoder()
                        let product = try! decoder.decode(dataResponse.self, from: data)
                        
                        // change variable status
                        let objectProduct = product
                        print("objectProduct: \(objectProduct)")
                        
                        let statusPago = product.data
                        print("Status Pago let is : \(statusPago)")
                        
                        for i in 0 ..< statusPago.count {
                            print("VARIABLE i es \(i)")
                            let resultadoArray = statusPago[i]
                            print("ResultadoArray \(resultadoArray.status)")
                            if resultadoArray.status == "APPROVED"{
                                print("LA COMPRA SE REALIZO CORRECTAMENTE")
                                
                                //Sends email to user of purshased items
                                var newProductsString = ""
                                
                                var productsToString = ""
                                
                                print("CURRENT USER EMAIL = \(String(describing: viewModel.currentUser?.email)) otro =\(viewModel.currentUserEmail)")
                                
                                for i in 0 ..< cartmanager.numberOfProducts {
                                    
                                    let product = cartmanager.cartproducts[i]
                                    
                                    newProductsString = newProductsString + "<tr><td><br><img style=\"width:150px; border-radius: 20px;\" src=\(product.thumbnail)/></td> <td><br> <b>Producto:</b>\(product.title) <br> <b> Talla:\(product.tallaFinal) <br> <b>Cantidad:</b>\(product.cantidad) </td></tr><br><br> ____________________<br>"
                                    
                                    productsToString = productsToString + "Talla=\(product.tallaFinal) + Titulo=\(product.title) - Cantidad=\(product.cantidad)"
                                }
                                
                                cartmanager.triggerPurshasedResult(result: resultadoArray.status,carrito: productsToString, correo: correo,nombre: nombre, documento: documento, departamento: departamento, ciudad: ciudad, direccion: direccion, telefono: telefono)
                                
                                Task{
                                    await viewModel.sendEmailToUser(to: "baudoagenciap@gmail.com",message: "Aporte exitoso, Baudó Ap"  , html:"""
                                                <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img>
                                                <h2>Hola, \(nombre)</h2>
                                        
                                                <h4> Gracias por tu aporte, estos son los artículos que llegarán a tu dirección registrada: \(direccion)</h4><br>
                                        
                                                <body><table>\(newProductsString) </table><br> <b>Total:</b>\(cartmanager.total)</body><br><br>
                                        
                                                <footer> Si tienes alguna duda o peticion sobre tu pedido, comunicate con nosotros a <a href="mailto:baudoagenciap@gmail.com">baudoagenciap@gmail.com</a> </footer>
                                        """)
                                    
                                   await viewModel.sendEmailToUser(to: self.correo, message: "Aporte exitoso, Baudó Ap"  , html:"""
                                                <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img>
                                                <h2>Hola, \(nombre)</h2>
                                        
                                                <h4> Gracias por tu aporte, estos son los artículos que llegarán a tu dirección registrada: \(direccion)</h4><br>
                                        
                                                <body>\(newProductsString) <br> <b>Total:</b>\(cartmanager.total)</body><br><br>
                                        
                                                <footer> Si tienes alguna duda o peticion sobre tu pedido, comunicate con nosotros a <a href="mailto:baudoagenciap@gmail.com">baudoagenciap@gmail.com</a> </footer>
                                        """)
                                    
                                    await viewModel.sendEmailToUser(to: viewModel.currentUser?.email ?? viewModel.currentUserEmail,message: "Aporte exitoso, Baudó Ap"  , html:"""
                                                <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img>
                                                <h2>Hola, \(nombre)</h2>
                                        
                                                <h4> Gracias por tu aporte, estos son los artículos que llegarán a tu dirección registrada: \(direccion)</h4><br>
                                        
                                                <body>\(newProductsString) <br> <b>Total:</b>\(cartmanager.total)</body><br><br>
                                        
                                                <footer> Si tienes alguna duda o peticion sobre tu pedido, comunicate con nosotros a <a href="mailto:baudoagenciap@gmail.com">baudoagenciap@gmail.com</a> </footer>
                                        """)
                                    
                                }
                                
                                //Upload array of cart to Firebase
                                
                                cartmanager.cartproducts = []
                                cartmanager.numberOfProducts = 0
                            }
                            if resultadoArray.status == "DECLINED"{
                                print("Purshased was declined ")
                            }
                            
                            // OTROS CASOS AQUI
                        }
                    }
                }
            }
            print("TASK HERE printed: ",task)
            task.resume()
        }
    }
}


struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout()
    }
}



