//
//  EditProfileView.swift
//  BaudoAP
//
//  Created by Codez Studio on 3/07/23.
//

import SwiftUI
import Firebase
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State private var newfullname = ""
    
    var body: some View {
        VStack{
            
            //toolbar
            VStack{
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .subheadline))
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.custom("SofiaSans-Regular",size: 18,relativeTo: .subheadline))
                        
                    Spacer()
                    
                    Button{
                       
                        if image != nil {
                            viewModel.uploadImageToStorage(image: self.image!) { imageURLString in
                                if let url = imageURLString {
//                                    let imageURLString = url
                                    // Save the image URL to Firestore
                                    Task{
                                        try await viewModel.updateUserPic(image: url)
                                    }
                                    dismiss()
                                }
                            }
                        }
                        
                        if self.newfullname != "" {
                            Task{
                                try await viewModel.updateUserName(newName: self.newfullname)
                                dismiss()
                            }
                        }
                        
                        
                    } label: {
                        Text("Done")
                            .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .subheadline))
                    }
                }.padding()
                
                Divider()
            }
            HStack{
                // edit profile pic
                Button{
                    shouldShowImagePicker = true
                }label: {
                    
                    VStack{
                        
                        
                        if let image = viewModel.currentUser?.user_pic {
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120,height: 120,alignment: .center)
                                    .cornerRadius(100)
                            } else {
                                if image != "" {
                                    KFImage(URL(string: viewModel.currentUser?.user_pic ?? ""))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120 ,height: 120)
                                        .cornerRadius(60)
                                        .padding(2)
                                        .overlay(RoundedRectangle(cornerRadius: 60) .stroke(Color("Buttons"), lineWidth: 1))
                                    } else {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .padding(10)
                                            .foregroundColor(Color("Buttons"))
                                            .frame(width: 120,height: 120,alignment: .center)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .padding(2)
                                            .cornerRadius(120)
                                            .overlay(RoundedRectangle(cornerRadius: 120) .stroke(Color("Buttons"), lineWidth: 1))
                                    }
                            }
                        } else {
                            Text("No currentUserUserPic Fetched Here")
                        }
                        
                        Text("Editar foto de perfil")
                        
                    }
                    
                    
                }
            }
            
            HStack{
                Text("Nombre")
                    .font(.custom("SofiaSans-Bold",size: 15,relativeTo: .title2))
                    .padding(.leading,20)
                Spacer()
            }
            TextField("Nombre", text: $newfullname)
                .padding()
                .foregroundColor(.black)
                .textFieldStyle(.plain)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
            
           
            // edit profile info
            
            Spacer()
        }
        
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $image)
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(AuthViewModel())
    }
}
