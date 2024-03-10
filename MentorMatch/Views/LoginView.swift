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
            
            TextField("Введите почту", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 8))
                .cornerRadius(15)
                .padding(.horizontal, 15)
                .padding(.top, 100)
            
            SecureField("Введите пароль", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 8))
                .cornerRadius(15)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
            Spacer()
            
            ButtonView(title: "Войти") {
                isLoggedIn.toggle()
            }
            .padding(.horizontal, 120)
            .padding(.bottom, 15)
            
        }
        .fullScreenCover(isPresented: $isLoggedIn) {
            TabBar()
        }
    }
}

#Preview {
    LoginView()
}


