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
    
    var body: some View {
        VStack {
            Text("Добро пожаловать!")
                .fontWeight(.bold)
                .font(.system(size: 44))
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            
            FieldView(maxLength: 239, prevText: "введите почту", type: "usual")
                .padding(.top, 100)
            FieldView(maxLength: 239, prevText: "введите пароль", type: "password")
                .padding(.horizontal, -15)
            
            Spacer()
            
            ButtonView(title: "Войти") {
                isLoggedIn.toggle()
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(
                isPresented: $isLoggedIn) {
                    TabBar()
                }
            .padding(.horizontal, 120)
            .padding(.bottom, 15)
            
        }
    }
}

#Preview {
    LoginView()
}


