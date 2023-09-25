//
//  CartManager.swift
//  BaudoAP
//  Created by Codez on 9/06/23.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseAuth

@MainActor
class CartManager: ObservableObject {
    @Published var cartproducts: [Product] = []
    @Published var total: Int = 0
    @Published var numberOfProducts: Int = 0
    
    @Published var compraRealizada = ""
    
    func addProduct(product: Product, cantidad: Int, size_final: String){
                
        var prodMod = product
        prodMod.tallaFinal = size_final
        prodMod.cantidad = cantidad
        
        cartproducts.append(prodMod)
        self.numberOfProducts += cantidad
        
        print("price product=",product.price)
        let cleanedStr = product.price.replacingOccurrences(of: ".", with: "")
        let priceInt = Int(cleanedStr) ?? 0
        let totalProd = priceInt * cantidad
        
        total += totalProd
    }
    
    func removeProduct(product: Product){
        if let index = cartproducts.firstIndex(of: product) {
            cartproducts.remove(at: index)
        }

        self.numberOfProducts -= product.cantidad
        let cleanedStr = product.price.replacingOccurrences(of: ".", with: "")
        let priceInt = Int(cleanedStr) ?? 0
        let tot = priceInt * product.cantidad
        total -= tot
    }
    
    func SendPurchesed(){
        print("Productos comprados para Firebase aqui")
    }
    
    
    @MainActor
    func triggerPurshasedResult(result: String,carrito: String,correo: String, nombre: String, documento: String, departamento: String, ciudad: String, direccion: String, telefono: String){
        
        
        print("aqui hago lo que necesito para la compra y mostrarla. jeje")
        compraRealizada = result
        
        let userEmail: String = (Auth.auth().currentUser?.email ?? "")
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestampString = dateFormatter.string(from: currentDate)
        
        let nameDoc = userEmail + "-" + timestampString
        
        print("CompraRealizada \(result)")
        
            if result == "APPROVED" {
                print("Aqui comprobe que la compra se pago exitosamente y meto los datos de cart a user.")
                // SUBIR DATOS A USUARIO Y COMPRAS
                
                let db = Firestore.firestore()
                let ref = db.collection("compras").document(nameDoc)
                ref.setData(["Resultado": result ,"nombre_usuario": nombre,"productos": carrito ,"correo": correo, "nombre": nombre, "documento": documento, "departamento": departamento, "ciudad": ciudad, "direccion": direccion, "telefono": telefono])
            }
            
            if result == "DECLINED" {
                print("Aqui comprobe que la compra se Declino. y envio correo de buen intento jejeje.")
                // SUBIR DATOS A USUARIO Y COMPRAS
            }
        
        
    }
}


