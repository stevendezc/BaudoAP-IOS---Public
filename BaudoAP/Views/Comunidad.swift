//
//  Comunidad.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//

import SwiftUI

struct Comunidad: View {
    @ObservedObject var users = ContentViewModelComunidad()
//    @State var filteredComunidad: [Users] = []
    
    @State private var showFilteredResultsproductivos = false
    @State private var showFilteredResultscultura = false
    @State private var showFilteredResultsturismo = false
    
    @State private var isPresentedInfoC = false
    
    var ToToggle = false
    
    var filteredComunidad: [Users] {
           if showFilteredResultsproductivos {
               return users.usersComunidad.filter({$0.category == "productivos"})
           } else if showFilteredResultscultura{
               return users.usersComunidad.filter({$0.category == "cultura"})
           } else if showFilteredResultsturismo{
               return users.usersComunidad.filter({$0.category == "turismo"})
           }
            else {
                return users.usersComunidad
            }
       }
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                Text("").id("TopToScrollComunidad")
                VStack(alignment: .leading){
                    HStack(spacing: 2){
                        Button {
                            showFilteredResultsproductivos.toggle()
                            showFilteredResultscultura = false
                            showFilteredResultsturismo = false
                        } label: {
                            
                            HStack{
                                Image("Tomate")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:20)
                                Text("Proyectos \n productivos")
                                    .font(.custom("SofiaSans-Regular",size: 9,relativeTo: .title2))
                                    .foregroundColor(showFilteredResultsproductivos ? Color(.black) : Color("Text"))
                            }
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal,13)
                            .padding(.vertical,5)
                            .background(showFilteredResultsproductivos ? Color("Yellow") : Color("BackgroundCards"))
                            .cornerRadius(20)
                            
                                
                        }.padding(0)
                        
                        Button {
                            showFilteredResultsproductivos = false
                            showFilteredResultscultura.toggle()
                            showFilteredResultsturismo = false
                        } label: {
                            HStack{
                                Image("Casita")
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .frame(width:20)
                                Text("Cultura e \n inclusión")
                                    .font(.custom("SofiaSans-Regular",size: 9,relativeTo: .title2))
                                    .foregroundColor(showFilteredResultscultura ? Color(.black) : Color("Text"))
                            }
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal,13)
                            .padding(.vertical,5)
                            .background(showFilteredResultscultura ? Color("Yellow") : Color("BackgroundCards"))
                            .cornerRadius(20)
                        }
                        
                        Button {
                            showFilteredResultsproductivos = false
                            showFilteredResultscultura = false
                            showFilteredResultsturismo.toggle()
                        } label: {
                            
                            HStack{
                                Image("Point")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:17)
                                Text("Turismo\n comunitario")
                                    .font(.custom("SofiaSans-Regular",size: 9,relativeTo: .title2))
                                    .foregroundColor(showFilteredResultsturismo ? Color(.black) : Color("Text"))
                                    
                            }
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal,13)
                            .padding(.vertical,5)
                            .background(showFilteredResultsturismo ? Color("Yellow") : Color("BackgroundCards"))
                            .cornerRadius(20)
                        }
                        Spacer()
                        Button{
                            isPresentedInfoC = true
                        } label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25,height: 25, alignment: .trailing)
                                .foregroundColor(Color("Buttons"))
                        }
                        
                    }.padding(5)
                    
                    ForEach(filteredComunidad) { Users in
                        PostCardComunidad(model: Users)
                    }
                }
                .padding(.horizontal,10)
            }
            .sheet(isPresented: $isPresentedInfoC) {
                InfoViewTComunidad()
                    .presentationDetents([.fraction(0.5)])
                    .presentationBackground(.black.opacity(0.9))
                    .presentationCornerRadius(20)
            }
//            .refreshable {
//                users.fetchusersComunidad()
//            }
        }
    }
}

struct InfoViewTComunidad: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            HStack{
                VStack{
                    HStack{
                        Text("Queremos ser puente")
                            .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title2))
                            .padding(.vertical)
                        Spacer()
                    }
                    
                    Text("Entre las comunidades de todos los territorios de Colombia y la comunidad baudoseña. Aquí encontrarás emprendimientos locales y comunitarios de todo el país.\n\n Si quieres hacer parte de esta red escríbenos a comunidades.baudoap@gmail.com o el teléfono+57 321 7344601.")
                        .font(.custom("SofiaSans-Bold",size: 16,relativeTo: .title2))
                }
                .foregroundColor(.white)
                .font(.custom("SofiaSans-Medium",size: 18,relativeTo: .title2))
                .padding(.bottom,20)
                .overlay(Rectangle().frame(maxWidth: .infinity,maxHeight: 1, alignment: .bottom).foregroundColor(Color("AccentColor")), alignment: .bottom)
            }
            .padding(.horizontal,30)
            
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



struct Comunidad_Previews: PreviewProvider {
    static var previews: some View {
        Comunidad()
    }
}



