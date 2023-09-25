//
//  SwiftUIView.swift
//  BaudoAP
//
//  Created by Codez Studio on 10/07/23.
//

import SwiftUI

struct EventsCard: View {
    
    var model: Event
    
    @State private var showWebView = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Yellow"))
            .edgesIgnoringSafeArea(.horizontal)
            
            HStack{
                Spacer()
            }
            HStack{
                Text(model.creationDateString)
                    .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title))
                Text(String(model.year))
                    .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title))
            }
            .font(.custom("SofiaSans-Black",size: 25,relativeTo: .title))
            
            Text(model.date_range)
                .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
            Text(model.title)
                .font(.custom("SofiaSans-Black",size: 18,relativeTo: .body))
            Text(model.description)
                .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .body))
            Text("Modalidad: \(model.subject)")
                .font(.custom("SofiaSans-Medium",size: 15,relativeTo: .caption))
            HStack{
                Button{
                    showWebView.toggle()
                    print("URL", model.eventUrl)
                } label: {
                    HStack{
                        Image(systemName: "link")
                        Text("Ir al evento")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .caption))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,15)
                    .background(Color("Yellow"))
                    .foregroundColor(.black)
                    .cornerRadius(30)
                }
                Button{
                    if viewModel.RemindersGuardados.contains(model.id ?? ""){
                        print("Contains model in array")
                        //remove from array
                    } else {
                        requestNotificationAuthorization()
                        scheduleNotification(dateEvent: model.event_date, title: model.title, subtitle: model.description)
                        print(model.event_date)
                        // Add to array 
                        viewModel.setReminderUser(PostId: model.id ?? "")
                        // toggle alert
                        showingAlert.toggle()
                    }
                    
                } label: {
                    HStack{
                        Image(systemName: "bell.fill")
                        Text("Recordatorio")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .body))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,15)
                .background(viewModel.RemindersGuardados.contains(model.id ?? "") ? Color("Yellow") : Color(.gray))
                .foregroundColor(.black)
                .cornerRadius(30)
                
            }
        }
        .padding(.bottom,20)
        .sheet(isPresented: $showWebView){
            SafariWebView(url: model.eventUrl)
                
        }
        .alert("Notificacion programada", isPresented: $showingAlert) {
            // add buttons here
        } message: {
            Text("Has programado un recordatorio para el evento **\(model.title)** para el \(model.event_date)")
        }
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(dateEvent: Date, title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        //TRIGGER DAY BEFORE
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: dateEvent)!
        print("Modified date one day before \(modifiedDate)")
        let triggerDateBefore = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: modifiedDate)
        let triggerBefore = UNCalendarNotificationTrigger(dateMatching: triggerDateBefore
                                                          , repeats: false)
        // choose a random identifier
        let requestBefore = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerBefore)
        
        // add our notification request
        UNUserNotificationCenter.current().add(requestBefore)
        
        //TRIGGER NOTIFICATION FOR THE EVENT TIME
        let date = dateEvent // Example: Set the notification to fire 60 seconds from the current time
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

struct EventsCard_Previews: PreviewProvider {
    static var previews: some View {
        EventsCard(model: Event(event_date: Date(), date_range: "13 al 20 de agosto", description: "Description de ensayo para ver como se veria un evento elegante", eventUrl: "https://baudoap.com", month: 8, subject: "ambiente", title: "Relanzamiento de los 12", year: 2023))
    }
}
