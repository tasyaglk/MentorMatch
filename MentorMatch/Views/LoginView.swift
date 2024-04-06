//
//  LoginView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 08.03.2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var isLoggedIn: Bool = false
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    @State private var hasEmptyFields: Bool = false
    @EnvironmentObject var authFirebase: AuthFirebase
    
    func logIn(email: String, password: String) {
        authFirebase.signIn(email: email, password: password) { result in
            switch result {
            case (.success(_)) :
                isLoggedIn.toggle()
            case(.failure(let error)):
                //authFirebase.errorMessage = error.errorMessage
                alertMessage = "неверно введенные данные"
                isAlertShow.toggle()
            }
        }
    }
    
    var content: some View {
        VStack {
            Text("Добро пожаловать!")
                .fontWeight(.bold)
                .font(.system(size: 44))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            FieldView(isError: hasEmptyFields && email.isEmpty, maxLength: 239,labelText: "", type: "usual", prevText: "введите почту", keyboardType: .emailAddress, text: $email )
                //.padding(.top, 100)
            FieldView(isError: hasEmptyFields && password.isEmpty, maxLength: 239,labelText: "", type: "password", prevText: "введите пароль", keyboardType: .emailAddress, text: $password )
                .padding(.horizontal, 15)
            
            Spacer()
            
            ButtonView(title: "Войти") {
                if  email.isEmpty || password.isEmpty {
                    hasEmptyFields = true
                } else {
                    logIn(email: email, password: password)
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton(text: ""))
            .navigationDestination(
                isPresented: $isLoggedIn) {
                    TabBar()
                }
            .padding(.horizontal, 120)
            .padding(.bottom, 15)
            .alert(isPresented: $isAlertShow) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
        }
    }
    
    var body: some View {
        if authFirebase.signedIn {
            TabBar()
        } else {
            content
        }
    }
}

#Preview {
    LoginView()
}


