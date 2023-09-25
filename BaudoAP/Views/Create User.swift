//
//  Create User.swift
//  BaudoAP
//
//  Created by Codez on 24/04/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct createUser : View {
    
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var user_pic = ""
    //    @Binding var userIsLogged : Bool
    @State var Politica = false
    @State var isSecure = true
    @State var triggerAlert = false
    @State var showVerifyEmailAlert = false
    
    @FocusState var isEmailFocused : Bool
    @FocusState var isNameFocused : Bool
    @FocusState var isPasswordFocused : Bool
    
    @State var shouldShowImagePicker = false
    
    let impactNotification = UINotificationFeedbackGenerator()
    @State var image: UIImage?
    @State var StatusMessage = ""
    @Environment(\.dismiss) private var dismiss
    
    var isLoginFormValid:Bool {
        !email.isEmpty && email.contains("@") && !name.isEmpty && !password.isEmpty && Politica == true
    }
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
//        NavigationView{
            
                VStack(spacing: 10) {
                    
                    Group{
//                        Image("LogoBaudoSmall")
                        HStack{
                            Text("Ingresa tus datos para registrarte")
                                .font(.custom("SofiaSans-Bold",size: 20,relativeTo: .title))
                            
                        }
                        
                        .padding(.vertical,10)
                    }
                    
                    Group{
                        
                        Button{
                            shouldShowImagePicker = true
                        }label: {
                            
                            if let image = self.image {
                                ZStack(alignment: .topTrailing){
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100,height: 100,alignment: .center)
                                        .cornerRadius(100)
                                        .padding(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 150)
                                                .stroke(.black, lineWidth: 1)
                                        )
                                    
                                    Image(systemName: "photo")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(.black)
                                        .clipShape(Circle())
                                }
                            } else {
                                ZStack(alignment: .topTrailing){
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 70))
                                        .padding(10)
                                        .foregroundColor(Color.black)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(10)
                                        .cornerRadius(50)
                                        .background(.gray.opacity(0.7))
                                        .clipShape(Circle())
                                        .padding(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 90)
                                                .stroke(.black, lineWidth: 1)
                                        )
                                    Image(systemName: "photo")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(.black)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        Text("Selecciona una imagen")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                        
                        Group{
                            HStack{
                                Text("Nombre")
                                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                    .padding(.leading,20)
                                Spacer()
                            }
                            TextField("Nombre", text: $name)
                                .focused($isNameFocused)
                                .padding()
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(20)
                            if self.name.isEmpty && triggerAlert{
                                Text("Porfavor ingresa tu nombre")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                            
                            HStack{
                                Text("Correo")
                                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                    .padding(.leading,20)
                                Spacer()
                            }
                            TextField("Correo", text: $email)
                                .focused($isEmailFocused)
                                .padding()
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(20)
                            if self.email.isEmpty && triggerAlert{
                                Text("Porfavor ingresa un correo valido")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                            
                            HStack{
                                Text("Contraseña")
                                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                    .padding(.leading,20)
                                Spacer()
                            }
                            
                            ZStack(alignment: .trailing){
                                if isSecure {
                                    
                                    SecureField("Contraseña", text:$password)
                                        .focused($isPasswordFocused)
                                        .padding()
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(20)
                                    Button{
                                        isSecure.toggle()
                                        impactNotification.notificationOccurred(.success)
                                    } label:{
                                        Image(systemName: "eye.slash")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    
                                } else {
                                    TextField("Contraseña", text:$password)
                                        .padding()
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(20)
                                    Button{
                                        isSecure.toggle()
                                        impactNotification.notificationOccurred(.success)
                                    } label:{
                                        Image(systemName: "eye")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                }
                            }
                            if self.password.isEmpty && triggerAlert{
                                Text("Porfavor ingresa una contraseña")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Group{
                            
                            Toggle(isOn: $Politica){
                                NavigationLink(destination: AcuerdoConfidencialidad(), label: {
                                    HStack{
                                        Text("Acepto la")
                                            .foregroundColor(.black)
                                        
                                        Text("politica de datos")
                                            .foregroundColor(.black)
                                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                                    }
                                })
                            }
                                .font(.custom("SofiaSans-Regular",size: 15,relativeTo: .title2))
                                .tint(Color("Buttons"))
                                .padding(10)
                            if !self.Politica && triggerAlert{
                                Text("Debes aceptar las politicas de datos.")
                                    .font(.custom("SofiaSans-Bold",size: 12,relativeTo: .caption))
                                    .foregroundColor(.red)
                            }
                         
                            Button{
                                if isLoginFormValid {
                                    
//                                    self.showVerifyEmailAlert = true
                                    viewModel.shouldShowOnBoarding = true
                                    impactNotification.notificationOccurred(.success)
                                    Task{
                                        register()
                                    }
                                } else {
                                    triggerAlert = true
                                }
                                
                            }label: {
                                Text("Registrarme")
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(isLoginFormValid ? Color("Buttons") : Color.gray)
                                    .clipShape(Capsule())
                                    .padding(.top)
                            }
                        }
                    }
                }
                .padding(30)
                .background(
                    Image("Fondo")
                        .padding(.top,-5)
                        .ignoresSafeArea()
                )
        .environmentObject(viewModel)
//        .onTapGesture {
//            // Dismiss the keyboard when tapping outside the text field
//            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $image)
        }
        
        
//        .alert(isPresented: $showVerifyEmailAlert){
//            Alert(title: Text("Registro completado"),
//                  message: Text("Por favor, verifica tu correo. Ve a tu bandeja de entrada o spam y da click en el link enviado por Baudo Ap."),
//                  dismissButton: .default(Text("Listo!")))
//        }
    }

    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Usuario Registrado ahora llamo a persistImage")
                
                Task{
                    await viewModel.sendEmailToUser(to: email,message: "¡Gracias por sumarte a este río de historias!"  , html:"""
                    <img style="width:100%" src="https://firebasestorage.googleapis.com/v0/b/baudoapp-c89ed.appspot.com/o/Fijo%2FEncabezado%207.jpg?alt=media&token=6c71d9e8-c9e1-4771-8bc1-1f5e783d5f2d"> </img><br>
                    <div>
                    <h2> Hola, \(name)</h2><br><br>
                        En Baudó APP encontrarás contenido exclusivo, eventos destacados, emprendimientos comunitarios e información de primera mano de todas las regiones del país con voces auténticas de cada comunidad.<br><br>
                        Un abrazo,
                        El equipo de Comunicaciones de Baudó Agencia Pública
                    </div>
                    """)
                }
                
                if image != nil {
                    persistImageToStorage()
                }
                else {
                    createUserDocument()
                }
                
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    // ...
                    print("Verification Email Sent")
//                    viewModel.fetchUser()
                }
            }
        }
    }
    
    
    
    func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Storage.storage().reference(withPath: "/UserImages/\(uid).jpg")
        
        //        let metadata = StorageMetadata()
        //        metadata.contentType = "image/jpg"
        
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.05) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.StatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.StatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.StatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print("\(String(describing: url?.absoluteString))")
                
                user_pic = url?.absoluteString ?? ""
                print(user_pic)
                
                print("Todo bien en image persist ahora llamo a createUserDocument")
                // do stuff
                createUserDocument()
            }
        }
    }
    
    func createUserDocument(){
        let db = Firestore.firestore()
        print("Got firestore db reference")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("Got currentUser UID: \(uid)")
        let ref = db.collection("users").document(email)
        //      let ref = db.collection("users").document(email)
        ref.setData(["uid": uid ,"name": name, "password": password,"user_pic": user_pic,"email": email]) { err in
            if let err = err {
                self.StatusMessage = "Failed to create user document\(err)"
                return
            } else {
                print("SUCCESSFULLY ACCOUNT ADDED AND PHOTO UPLOADED AND URL DOWNLOADED NOW FETCH USER INFO ")
                viewModel.fetchUser()
//                self.showVerifyEmailAlert = true
            }
        }
    }
}

//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}


struct Create_User_Previews: PreviewProvider {
    static var previews: some View {
        createUser()
    }
}



