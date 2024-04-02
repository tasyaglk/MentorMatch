//
//  SettingsView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = AuthFirebase()
    @State private var profileImage: Image = Image(systemName: "person")
    //@State private var name: String = "John Doe"
    @State private var isEditName: Bool = false
    @State private var newName: String = ""
    @State var isSave: Bool = false
    @State var isEducation: Bool = false
    @State var isExperience: Bool = false
    @State var isExpertise: Bool = false
    @State var isLogOut: Bool = false
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    //    @State  var user: UserM
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var status: String = ""
    @State private var description: String = ""
    @State private var email: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        
//        ScrollView {
            VStack {
                FieldView(maxLength: 239, labelText: "имя", type: "settings", prevText: user.firstName, keyboardType: .default, text: $firstName)
                FieldView(maxLength: 239, labelText: "фамилия", type: "settings", prevText: user.lastName, keyboardType: .default, text: $lastName)
                FieldView(maxLength: 20, labelText: "Статус", type: "settings", prevText: user.status, keyboardType: .default, text: $status)
                FieldView(maxLength: 20, labelText: "Описание", type: "settings", prevText: user.description, keyboardType: .default, text: $description)
                
                ArrowButtonView(title: "навыки") {
                    isExpertise.toggle()
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(
                    isPresented: $isExpertise) {
                        ExpertiseView()
                    }
                    .padding(.top, 10)
                ArrowButtonView(title: "образование") {
                    isEducation.toggle()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: CustomBackButton(text: ""),
                    trailing:  Button(action: {
                        isSave.toggle()
                        viewModel.saveNewMainInfo(firstName: firstName, lastName: lastName, email: email, status: status, description: description) {  result in
                            switch result {
                            case (.success(_)) :
                                isSave.toggle()
                            case(.failure(let error)):
                                alertMessage = "ошибка входа"
                                isAlertShow.toggle()
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Сохранить")
                            .foregroundColor(Color("main_color"))
                    }
                )
                .navigationDestination(
                    isPresented: $isEducation) {
                        EducationView()
                    }
                ArrowButtonView(title: "опыт") {
                    isExperience.toggle()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton(text: ""))
                .navigationDestination(
                    isPresented: $isExperience) {
                        ExperienceView()
                    }
                
                Spacer()
                
                ButtonView(title: "выйти", height: 50, color: "main_color") {
                    viewModel.handleSignOut()
                    
                }
                .padding(.horizontal, 100)
//            }
        }
        .onAppear {
            let user = viewModel.getUser() ?? UserM()
            email = user.email
            firstName = user.firstName
            lastName = user.lastName
            status = user.status
            description = user.description
        }
        .navigationDestination(isPresented: $viewModel.isUserLoggedOut) {
            WelcomeView()
        }
        
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
