//
//  WelcomeView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 07.03.2024.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    @State var isLogged: Bool = false
    @State var isRegistrated: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("main_color").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    Spacer()
                    
                    ButtonView(title: "Войти",  color: "white_app") {
                        isLogged.toggle()
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(
                        isPresented: $isLogged) {
                            LoginView()
                        }
                    .padding(.horizontal, 40)
                    
                    ButtonView(title: "Зарегистрироваться",  color: "white_app") {
                        isRegistrated.toggle()
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(
                        isPresented: $isRegistrated) {
                            RegisterFirstView()
                        }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 35)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}




//#Preview {
//    WelcomeView(isLoggedIn: false)
//}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


// t4@t.ru
// tttttt
