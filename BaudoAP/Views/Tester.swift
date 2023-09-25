import SwiftUI

struct Tester: View {
    
    
   
    var body: some View {
        Group{
            Button{
//                WompiCallCreateLink(amount: 50000000)
                //            WompiCallGetLink()
                //            WompiGetLinkFromLink()
                
                WompiCallGetLink()
            }label: {
                Text("Escuchar Trasaccion")
            }
            
            Button{
                
            } label: {
                Text("Entrar al evento")
            }
        }
    }
    
    // CHECK WHERE
    // LINK TO OPEN https://checkout.wompi.co/l/test_Hg1bpc   https://checkout.wompi.co/l/test_GhFDnm
    
    func WompiCallCreateLink(amount: Int) {
        //    let baseURL = "https://api.wompi.co/v1"
        //    let endpoint = "/transactions"
//      let url = URL(string: "https://sandbox.wompi.co/v1/payment_links")!
        let url = URL(string: "https://sandbox.wompi.co/v1/transactions?reference=TtT2iAADWbmuW229NKdl2")!
    

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer prv_test_z8LqRarGCpwB5tnCk4ffGcTHJlZy2da1", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let payload: [String: Any] = [
            "name": "Prueba pasandole data",
              "description": "Pago Productos tienda",
              "single_use": false,
              "collect_shipping": false,
              "collect_customer_legal_id": false,
              "amount_in_cents": amount,
              "currency": "COP",
//              "sku": "1",
              "expires_at": "2023-12-10T14:30:00",
              "redirect_url": "https://baudoap.com/agredecimiento",
              "image_url": "https://micomercio.co/tienda/logo",
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
            request.httpBody = jsonData
        } catch {
            // Error occurred while serializing the JSON payload
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Error occurred while making the API request
                print("ERROR EN EL URLSession",error)
            } else if let data = data {
                // Handle the API response data
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("RETORNO DE WOMPI AQUI = ",responseJSON as Any)
                    // Process the response JSON
                } catch {
                    // Error occurred while parsing the response JSON
                }
            }
        }

        task.resume()
    }
    
    func WompiCallGetLink() {
        //    let baseURL = "https://api.wompi.co/v1"
        //    let endpoint = "/transactions"
//      let url = URL(string: "https://sandbox.wompi.co/v1/payment_links")!
//        let url = URL(string: "https://sandbox.wompi.co/v1/payment_links/test_OkIrhJ")!
        
        let url = URL(string: "https://sandbox.wompi.co/v1/transactions?reference=TtT2iAADWbmuW229NKdl")!
    
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer prv_test_z8LqRarGCpwB5tnCk4ffGcTHJlZy2da1", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let payload: [String: Any] = [
//            "name": "Prueba pasandole data",
//              "description": "Pago Productos tienda",
//              "single_use": false,
//              "collect_shipping": false,
//              "collect_customer_legal_id": false,
//              "amount_in_cents": amount,
//              "currency": "COP",
//              "sku": "CDX-812345-1ADD",
//              "expires_at": "2023-12-10T14:30:00",
//              "redirect_url": "https://micomercio.co/tienda",
//              "image_url": "https://micomercio.co/tienda/logo",
//
//        ]
        
//        do {
////            let jsonData = try JSONSerialization.data()
////            request.httpBody = jsonData
//        } catch {
//            // Error occurred while serializing the JSON payload
//        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Error occurred while making the API request
                print("ERROR EN EL URLSession",error)
            } else if let data = data {
                // Handle the API response data
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("RETORNO DE GET FUNCTION HERE WOMPI AQUI = ",responseJSON as Any)
                    // Process the response JSON
                } catch {
                    // Error occurred while parsing the response JSON
                }
            }
        }

        task.resume()
    }
    
    func WompiGetLinkFromLink(){
        guard let url = URL(string: "https://sandbox.wompi.co/v1/payment_links/test_OkIrhJ") else {
            // Invalid URL
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Error occurred while fetching the data
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                // Invalid response
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                // No data received
                print("No data received")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                // Process the JSON data
                print("RESULTADO DEL GET JSON: ",json)
            } catch {
                // Error occurred while parsing JSON
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}
