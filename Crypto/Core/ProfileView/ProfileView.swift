//
//  ProfileView.swift
//  Crypto
//
//  Created by Данил Белов on 11.02.2023.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var assistentVM = AssistentViewModel(api: AssistentDataService(apiKey: API.openAIKey))
    @StateObject private var dataController = CoreDataManager()
    
    @State private var showProfileSettingsView: Bool = false
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.camera

    @AppStorage("firstName") var firstName = DefaultSettings.firstName
    @AppStorage("lastName") var lastName = DefaultSettings.lastName
    @AppStorage("bio") var bio = DefaultSettings.bio

    var body: some View {
        NavigationView {
            VStack {
                ProfileHeader(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)

                VStack(spacing: 10){
                    Text("\(firstName) \(lastName)")
                        .bold()
                        .font(.system(size: 30, weight: .bold, design: .rounded))


                    Text(bio)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, design: .rounded))

                    Button {
                        self.showProfileSettingsView = true
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                    .padding(.top, 15)
                }
                .padding(.top, 5)

                Form {
                    Section {
                        Button {
                            showImagePickerOptions = true
                        } label: {
                            HStack {
                                Image(systemName: "camera")

                                Text("Change Profile Photo")
                            }
                        }
                        .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
                    }

                    Section {
                        
                        NavigationLink(destination: AssistentView(assistentVM: assistentVM)) {
                            Button {

                            } label: {
                                HStack {
                                    Image(systemName: "message")

                                    Text("Personal Assistant")
                                }
                            }
                        }

                        NavigationLink(destination: WalletView()) {
                            Button {

                            } label: {
                                HStack {
                                    Image("wallet")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 22)

                                    Text("Wallet")
                                }
                            }
                        }
                        
                        NavigationLink(destination: PaymentView().environment(\.managedObjectContext, dataController.container.viewContext)) {
                            Button {

                            } label: {
                                HStack {
                                    Image("card")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 22)

                                    Text("Payment")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showProfileSettingsView) {
                ProfileSettingsView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileHeader: View {
    
    @AppStorage("rValue") var rValue = DefaultSettings.rValue
    @AppStorage("gValue") var gValue = DefaultSettings.gValue
    @AppStorage("bValue") var bValue = DefaultSettings.bValue
    
    @Binding var showImagePickerOptions: Bool
    @Binding var showImagePicker: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    @State private var photo:UIImage?
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color(red: rValue, green: gValue, blue: bValue, opacity: 1.0))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)

            Image(uiImage: self.photo ?? UIImage(named: "PlaceholderImage")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 143, height: 143)
                .cornerRadius(100)
                .contentShape(Circle())
                .onTapGesture {
                    showImagePickerOptions = true
                }
                .padding(.top, 25)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$photo, isShown: self.$showImagePicker, sourceType: self.sourceType)
                .ignoresSafeArea()
        }
    }
}

struct ProfileSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @AppStorage("firstName") var firstName = DefaultSettings.firstName
    @AppStorage("lastName") var lastName = DefaultSettings.lastName
    @AppStorage("bio") var bio = DefaultSettings.bio
    
    @AppStorage("rValue") var rValue = DefaultSettings.rValue
    @AppStorage("gValue") var gValue = DefaultSettings.gValue
    @AppStorage("bValue") var bValue = DefaultSettings.bValue
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Circle()
                            .frame(width: 100)
                            .foregroundColor(Color(red: rValue, green: gValue, blue: bValue, opacity: 1.0))

                        VStack {
                            ColorSlider(value: $rValue, tintColor: .red)
                            ColorSlider(value: $gValue, tintColor: .green)
                            ColorSlider(value: $bValue, tintColor: .blue)
                        }
                    }
                }
                
                Section {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                } footer: {
                    Text("Enter your name and optional profile color")
                }
                
                Section {
                    TextEditor(text: $bio)
                } header: {
                    Text("Bio")
                } footer: {
                    Text("Any details such age, occupation or city.\nExample: 23 y.o. designer from San Francisco.")
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Exit") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

