//
//  PaymentMethodPSE.swift
//  BaudoAP
//
//  Created by Codez Studio on 13/07/23.
//

import SwiftUI


import SwiftUI

struct PaymentMethodPSE: View {
    
    @State var entidadFinanciera: String = ""
    @State var tipoPersona: String = ""
    @State var tipoIdentificacion: String = ""
    @State var numeroIdentificacion: String = ""

    
    @EnvironmentObject var wompivm: WompiViewModel
    
    @State var fields:[String] = []
    
    
    var body: some View {
        
//        @State var selectedOption: String = wompivm.EntidadesNames[0]
//        @State var currentIndex = 0
        @State var nombresInstituciones: [String] = wompivm.EntidadesNames
        
        ScrollView{
            
//            Text("\(wompiviewmodel.Entidades)")
            
//            Picker("Please choose a color", selection: $selectedOption) {
//                ForEach(nombresInstituciones, id: \.self) { option in
//                    Text(option)
//                }
//            }
            
            if wompivm.Entidades.count >= 0 {
                ForEach(wompivm.Entidades, id: \.self){ enti in
                    Text(enti.financialInstitutionCode)
                    Text("\(enti.financialInstitutionName)")
                }

            } else {
                Text("NO HAY ENTIDADES TODAVIA")
            }

            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text("Informacion \n PSE")
                        .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
                        .padding(20)
                        .foregroundColor(Color("Text"))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Group {
                    Text("Entidad financiera")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("Elegir banco", text: $entidadFinanciera)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                }
                
                Group {
                    Text("Tipo de persona")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("Natural o Juridica", text: $tipoPersona)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                }
                
                Group {
                    Text("Numero de identificacion")
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .padding(.leading,10)
                        .foregroundColor(Color("Yellow"))
                    TextField("425457854", text: $numeroIdentificacion)
                        .padding()
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                    
                }
                
            }
            
            
            Button{
                // llamado a la funcion transaccion
//                Task{
//                    await wompivm.getFinancialInstitutions()
//                }
                
                
                
                
            } label: {
                HStack{
                    Spacer()
                    Text("Continuar")
                        .padding(20)
                        .font(.custom("SofiaSans-Black",size: 20,relativeTo: .title2))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
                    Spacer()
                }
                .padding()
                
            }
        }
        .environmentObject(wompivm)
        .padding()
        .onAppear(){
            Task{
                await wompivm.getFinancialInstitutions()
            }
          
                
        }
    }
}

struct PaymentMethodPSE_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodPSE()
            .environmentObject(WompiViewModel())
    }
}
