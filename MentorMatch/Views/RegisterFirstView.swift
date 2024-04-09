////
////  RegisterFirstView.swift
////  MentorMatch
////
////  Created by Тася Галкина on 12.03.2024.
////
//
//import Foundation
//import SwiftUI
//
//struct RegisterFirstView: View {
//    @State var isNext: Bool = false
//    //@Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
//    private let user = UserM()
//    @ObservedObject var authFirebase = AuthFirebase()
//
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//
//    @State private var isAlertShow: Bool = false
//    @State private var alertMessage: String = ""
//
//    @State private var isSignUp: Bool = false
//
//
//    func signUp(email: String, password: String) {
//        authFirebase.signUp(email: email, password: password) { result in
//            switch result {
//            case (.success(_)) :
//                isNext = true
//                isSignUp =  true
//            case(.failure(let error)):
//                alertMessage = error.errorMessage
//                isAlertShow = true
//            }
//        }
//    }
//
//    var body: some View {
//        VStack {
//
//            FieldView(maxLength: 239, labelText: "имя", type: "preUsual", prevText: "введите имя", keyboardType: .default, text: $firstName)
//            FieldView(maxLength: 239, labelText: "фамилия", type: "preUsual", prevText: "введите фамилию", keyboardType: .default, text: $lastName)
//            FieldView(maxLength: 239, labelText: "почта", type: "email", prevText: "введите почту", keyboardType: .emailAddress, text: $email)
//            FieldView(maxLength: 239, labelText: "пароль", type: "password", prevText: "введите пароль", keyboardType: .default, text: $password)
//                .padding(.horizontal, 15)
//            Spacer()
//            ButtonView(title: "далее",  color: "main_color") {
//                isNext.toggle()
//                signUp(email: email, password: password)
//            }
//            .navigationDestination(
//                isPresented: $isNext) {
//
//                    RegistrationEdView(firstName: firstName, lastName: lastName, email: email, password: password)
//                }
//            .padding(.horizontal, 100)
//            .padding(.bottom, 15)
//        }
//        .padding(.top, 5)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: CustomBackButton(text: ""))
//    }
//}
//
//#Preview {
//    RegisterFirstView()
//}

import SwiftUI

struct RegisterFirstView: View {
    @State private var isNext: Bool = false
    //@Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    private let user = UserM()
    @ObservedObject var authFirebase = AuthFirebase()
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var isSignUp: Bool = false
    
    // State to track if there are empty fields
    @State private var hasEmptyFields: Bool = false
    
    func signUp() {
        authFirebase.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                isNext = true
                isSignUp = true
            case .failure(let error):
                alertMessage = error.errorMessage
                isAlertShow = true
            }
        }
    }
    
    
    var body: some View {
        
//        ImagePicker()
        
        VStack {
            FieldView(isError: hasEmptyFields && firstName.isEmpty, isError2: hasEmptyFields && firstName.isEmpty, maxLength: 239, labelText: "имя", type: "preUsual", prevText: "введите имя", keyboardType: .default, text: $firstName )
//                .border(hasEmptyFields && firstName.isEmpty ? Color.red : Color.clear)
            FieldView(isError: hasEmptyFields && lastName.isEmpty, isError2: hasEmptyFields && lastName.isEmpty, maxLength: 239, labelText: "фамилия", type: "preUsual", prevText: "введите фамилию", keyboardType: .default, text: $lastName)
//                .border(hasEmptyFields && lastName.isEmpty ? Color.red : Color.clear)
            FieldView(isError: hasEmptyFields && email.isEmpty, isError2: hasEmptyFields && email.isEmpty, maxLength: 239, labelText: "почта", type: "email", prevText: "введите почту", keyboardType: .emailAddress, text: $email)
//                .onChange(of: email) { newValue in
//                        // Приводим текст к нижнему регистру
//                        email = newValue.lowercased()
//                    }
//                .border(hasEmptyFields && email.isEmpty ? Color.red : Color.clear)
            FieldView(isError: hasEmptyFields && password.isEmpty, isError2: hasEmptyFields && password.isEmpty, maxLength: 239, labelText: "пароль", type: "password", prevText: "введите пароль", keyboardType: .default, text: $password)
//                .border(hasEmptyFields && password.isEmpty ? Color.red : Color.clear)
                .padding(.horizontal, 15)
            
            Spacer()
            
            ButtonView(title: "далее",  color: "main_color") {
                // Check for empty fields
                if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
                    hasEmptyFields = true
                } else {
                    isNext.toggle()
                    signUp()
                }
            }
            .navigationDestination(isPresented: $isNext) {
                RegistrationEdView(firstName: firstName, lastName: lastName, email: email, password: password)
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: ""))
    }
}

#Preview {
    RegisterFirstView()
}


