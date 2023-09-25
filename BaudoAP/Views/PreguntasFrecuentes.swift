//
//  PreguntasFrecuentes.swift
//  BaudoAP
//
//  Created by Codez Studio on 20/07/23.
//

import SwiftUI

struct PreguntasFrecuentes: View {
    var body: some View {
        ScrollView{
            Text("Preguntas frecuentes")
                .font(.custom("SofiaSans-Bold",size: 25,relativeTo: .title))
                .foregroundColor(Color("Text"))
                .padding(.top,20)
            //CARDS
            Group{
                
                //CARD con background
                VStack(alignment: .leading,spacing: 10){
                    Text("¿Cómo hago parte de la red comunitaria de Baudó AP?")
                        .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                    Text("Si quieres hacer parte de esta red escríbenos a comunidades.baudoap@gmail.com o el teléfono+57 321 7344601.")
                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title))
                }
                .foregroundColor(Color("Text"))
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color("BackgroundCards"))
                .cornerRadius(19)
                .padding()
                
                //CARD sin background
                VStack(alignment: .leading,spacing: 10){
                    Text("¿Cómo hago parte de la programación de eventos de Baudó AP?")
                        .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                    Text("Si quieres visibilizar tu evento o sugerir un evento comunidades.baudoap@gmail.com o el teléfono+57 321 7344601.")
                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title))
                }
                .foregroundColor(Color("Text"))
                .frame(maxWidth: .infinity)
                .padding(.horizontal,20)
                .padding()
                
                //CARD con background
                VStack(alignment: .leading,spacing: 10){
                    Text("¿Cómo me convierto en navegante?")
                        .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                    Text("Dirígete a la sección Navegates que se encuentra en el menú principal y selecciona el aporte que más se ajuste, a continuación sigue los pasos para ejecutar el pago.")
                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title))
                }
                .foregroundColor(Color("Text"))
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color("BackgroundCards"))
                .cornerRadius(19)
                .padding()
                
                //CARD sin background
//                VStack(alignment: .leading,spacing: 10){
//                    Text("¿Cómo accedo a la versión Premium de Baudó AP?")
//                        .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
//                    Text("Dirígete a la sección Navegates que se encuentra en el menú principal y selecciona el aporte que más se ajuste, a continuación sigue los pasos para ejecutar el pago.")
//                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title))
//                }
//                .foregroundColor(Color("Text"))
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal,20)
//                .padding()
                
                //CARD con background
                VStack(alignment: .leading,spacing: 10){
                    Text("Tengo un problema con un producto ¿Cómo lo soluciono?")
                        .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                    Text("Dirígete a perfil y accede a las configuraciones mediante el ícono de engranaje y selecciona “Contacto”, llena el formulario y escríbenos.")
                        .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title))
                }
                .foregroundColor(Color("Text"))
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color("BackgroundCards"))
                .cornerRadius(19)
                .padding()
                
                
            }//FIN GROUP
            
            
            
            
        }//FIN SCROLLVIEW
        
    }//FIN BODY
}

struct PreguntasFrecuentes_Previews: PreviewProvider {
    static var previews: some View {
        PreguntasFrecuentes()
    }
}
