//
//  WompiViewModel.swift
//  BaudoAP
//
//  Created by Codez Studio on 12/07/23.
//

import Foundation
import SwiftUI

@MainActor
class WompiViewModel: ObservableObject {
    
    @Published var Entidades: [dataEntidad] = []
    @Published var EntidadesCodes: [String] = []
    @Published var EntidadesNames: [String] = []
    
    @MainActor
    func getFinancialInstitutions() async {
        
        print("Antes de hacer el llamado1")
        //    let baseURL = "https://api.wompi.co/v1"
        //    let endpoint = "/transactions"
//      let url = URL(string: "https://sandbox.wompi.co/v1/payment_links")!
        let url = URL(string: "https://sandbox.wompi.co/v1/pse/financial_institutions")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer prv_test_z8LqRarGCpwB5tnCk4ffGcTHJlZy2da1", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Antes de hacer el llamado2")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP response error: \(httpResponse.statusCode)")
                return
            }
            
            if let jsonData = data {
            
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("JSON STRING NORMAL",jsonString)
                    
                }
            }
            
            guard let returned = try? JSONDecoder().decode(Entidad.self, from: data!)  else {
                print("No se ha convertido el json")
                return
            }
            print("JSON RETURNED \(returned.data.count), \(returned.data)")
            self.Entidades = returned.data
             
//          print("ENTIDADES YA RECIBIDAS PROCESADAS Y GUARDADAS",self.Entidades)
            
            Task{
                await self.crearEntidadesArray()
            }
//            print("ALL NAMES \(EntidadesNames)")
            
        }
        
        task.resume()
    }
    
    func crearEntidadesArray() async{
        for enti in Entidades{
    //                print("\(enti.financial)")
            self.EntidadesNames.append(enti.financialInstitutionName)
        }
        print("Entidades names = \(EntidadesNames)")
    }
}




//import Foundation
//
//let headers = [
//  "accept": "application/json",
//  "content-type": "application/json"
//]
//let parameters = [
//  "billing_address": [
//    "first_name": "stef",
//    "last_name": "ste",
//    "cedula": 100221,
//    "city": "pe",
//    "state": "risa",
//    "postcode": "666001",
//    "country": "CO",
//    "phone": 31525445524
//  ],
//  "requires_shipping": true,
//  "email": "stefe"
//] as [String : Any]
//
//let postData = JSONSerialization.data(withJSONObject: parameters, options: [])
//
//let request = NSMutableURLRequest(url: NSURL(string: "https://treli.co/wp-json/api/subscriptions/create")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "POST"
//request.allHTTPHeaderFields = headers
//request.httpBody = postData as Data
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//  if (error != nil) {
//    print(error as Any)
//  } else {
//    let httpResponse = response as? HTTPURLResponse
//    print(httpResponse)
//  }
//})
//
//dataTask.resume()
