//
//  Eventos.swift
//  BaudoAP
//
//  Created by Codez on 11/03/23.
//


import SwiftUI


struct Eventos: View {
    @ObservedObject var eventsviewmodel = EventsViewModel()
    
    @State var isActiveButtonCurrentYear: Bool = true
    @State var isActiveButtonNextYear: Bool = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    let currentYear = Calendar.current.component(.year, from: Date())
    let nextYear = Calendar.current.component(.year, from: Date()) + 1
    
//    let currentMonth =
    
       
    let options = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    let currentDate = Date()
    
    
    @State private var showFilteredResults = false
    @State private var showFilteredResultscultura = false
    @State private var showFilteredResultsturismo = false
    
    @State var ToToggle1 = false
    @State var ToToggle2 = false
    @State var ToToggle3 = false
    @State var ToToggle4 = false
    @State var ToToggle5 = false
    @State var ToToggle6 = false
    @State var ToToggle7 = false
    @State var ToToggle8 = false
    @State var ToToggle9 = false
    @State var ToToggle10 = false
    @State var ToToggle11 = false
    @State var ToToggle12 = false
    
    @State private var isPresentedInfoE = false
    
//    @State var selectedOption = (Calendar.current.dateComponents([.month], from: Date()).month ?? 1)
    @State var selectedOption = 0
    var filteredEvents: [Event] {
           if showFilteredResults {
               
               return eventsviewmodel.events.filter({$0.month == selectedOption})
           } else {
                return eventsviewmodel.events
//               return eventsviewmodel.events.filter({$0.month == selectedOption})
            }
       }
    
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text("").id("TopToScrollEventos")
                HStack{
                    Spacer()
                    
                    Button{
                        isPresentedInfoE = true
                    } label:{
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25,height: 25, alignment: .trailing)
                    }
                    
                }
                Text("Eventos")
                    .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .body))
                Spacer()
                Text(currentDate,style: .date)
                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                
                HStack{
                    Button{
                        isActiveButtonCurrentYear.toggle()
                        isActiveButtonNextYear.toggle()
                        
                    } label: {
                        Text(String(currentYear))
                            .font(.custom("SofiaSans-Bold",size : 18,relativeTo: .body))
                            .padding(.horizontal,15)
                            .padding(.vertical,10)
                            .background(isActiveButtonCurrentYear ? Color("Yellow") : Color("BackgroundCards"))
                            .cornerRadius(20)
                            .foregroundColor(Color("Text"))
                    }
                    Divider()
                        .frame(minHeight: 2)
                        .background(Color("Yellow"))
                        
                    Button{
                        isActiveButtonNextYear.toggle()
                        isActiveButtonCurrentYear.toggle()
                    } label: {
                        Text(String(nextYear))
                            .font(.custom("SofiaSans-Bold",size: 18,relativeTo: .body))
                            .padding(.horizontal,15)
                            .padding(.vertical,10)
                            .background(isActiveButtonNextYear ? Color("Yellow") : Color("BackgroundCards"))
                            .cornerRadius(20)
                            .foregroundColor(Color("Text"))
                    }
                }
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(options, id: \.self) { option in
                        Group{
                            if option == 1 {
                                Button{
                                    selectedOption = option
                                    if ToToggle1 {
                                        showFilteredResults = false
                                        ToToggle1.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle1.toggle()
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                    
                                } label: {
                                    if selectedOption == 1 {
                                        Text("Enero")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle1 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Enero")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle1 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 2 {
                                Button{
                                    selectedOption = option
                                    if ToToggle2 {
                                        showFilteredResults = false
                                        ToToggle2.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle2.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 2 {
                                        Text("Febrero")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle2 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Febrero")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle2 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 3 {
                                Button{
                                    selectedOption = option
                                    if ToToggle3 {
                                        showFilteredResults = false
                                        ToToggle3.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle3.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 3 {
                                        Text("Marzo")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle3 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Marzo")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle3 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                        
                        Group{
                            if option == 4 {
                                Button{
                                    selectedOption = option
                                    if ToToggle4 {
                                        showFilteredResults = false
                                        ToToggle4.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle4.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 4 {
                                        Text("Abril")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle4 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Abril")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle4 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            
                            if option == 5 {
                                Button{
                                    selectedOption = option
                                    if ToToggle5 {
                                        showFilteredResults = false
                                        ToToggle5.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle5.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 5 {
                                        Text("Mayo")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle5 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Mayo")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle5 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            
                            if option == 6 {
                                Button{
                                    selectedOption = option
                                    if ToToggle6 {
                                        showFilteredResults = false
                                        ToToggle6.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle6.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 6 {
                                        Text("Junio")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle6 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Junio")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle6 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                        
                        Group{
                            if option == 7 {
                                Button{
                                    selectedOption = option
                                    if ToToggle7 {
                                        showFilteredResults = false
                                        ToToggle7.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle7.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 7 {
                                        Text("Julio")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle7 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Julio")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle7 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 8 {
                                Button{
                                    selectedOption = option
                                    if ToToggle8 {
                                        showFilteredResults = false
                                        ToToggle8.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle8.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 8 {
                                        Text("Agosto")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle8 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Agosto")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle8 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 9 {
                                Button{
                                    selectedOption = option
                                    if ToToggle9 {
                                        showFilteredResults = false
                                        ToToggle9.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle9.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 9 {
                                        Text("Septiembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle9 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Septiembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle9 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                       
                        Group{
                            if option == 10 {
                                Button{
                                    selectedOption = option
                                    if ToToggle10 {
                                        showFilteredResults = false
                                        ToToggle10.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle10.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle11 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 10 {
                                        Text("Octubre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle10 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Octubre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle10 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 11 {
                                Button{
                                    selectedOption = option
                                    if ToToggle11 {
                                        showFilteredResults = false
                                        ToToggle11.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle11.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle12 = false
                                    }
                                } label: {
                                    if selectedOption == 11 {
                                        Text("Noviembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle11 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Noviembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle11 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            if option == 12 {
                                Button{
                                    selectedOption = option
                                    if ToToggle12 {
                                        showFilteredResults = false
                                        ToToggle12.toggle()
                                    } else {
                                        showFilteredResults = true
                                        ToToggle12.toggle()
                                        
                                        ToToggle1 = false
                                        ToToggle2 = false
                                        ToToggle3 = false
                                        ToToggle4 = false
                                        ToToggle5 = false
                                        ToToggle6 = false
                                        ToToggle7 = false
                                        ToToggle8 = false
                                        ToToggle9 = false
                                        ToToggle10 = false
                                        ToToggle11 = false
                                    }
                                } label: {
                                    if selectedOption == 12 {
                                        Text("Diciembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle12 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    } else {
                                        Text("Diciembre")
                                            .padding(.vertical,15)
                                            .frame(maxWidth:.infinity)
                                            .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .body))
                                            .foregroundColor(Color("Text"))
                                            .background(ToToggle12 ? Color("Yellow") : Color("BackgroundCards"))
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                
                if filteredEvents.count > 0 {
                    ForEach(filteredEvents){ event in
                        if event.event_date >= Date.now{
                            EventsCard(model: event)
                                .padding(.horizontal,30)
                        }
                    }
                } else {
                    Text("No hay eventos este mes")
                }
            }
        }
        .sheet(isPresented: $isPresentedInfoE) {
            InfoViewEventos()
                .presentationDetents([.fraction(0.6)])
                .presentationBackground(.black.opacity(0.8))
                .presentationCornerRadius(20)
        }
        .onAppear(){
            Task{
                try await eventsviewmodel.fetchEvents()
            }
            viewModel.fetchUser()
            print(viewModel.RemindersGuardados)
        }
        .onDisappear(){
            eventsviewmodel.stopListener()
        }
    }
}


struct InfoViewEventos: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Si te interesa el medio ambiente, los temas de derechos humanos, la cultura y el periodismo, esta agenda te ayudará a encontrar actividades que se desarrollan en el país.\n \n ¿Quieres compartir tu evento?  comunícate con nosotros a: comunidades.baudoap@gmail.com o el teléfono+57 321 7344601")
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
 

struct Eventos_Previews: PreviewProvider {
    static var previews: some View {
        Eventos()
    }
}
