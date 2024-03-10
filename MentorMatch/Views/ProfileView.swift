//
//  ProfileView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var username = "Taisiia Galkina"
    @State private var rate = "5.0"
    @State private var cntRevie = "239"
    @State private var status = "lalala"
    @State private var city = "Москва"
    @State private var description = "Senior"
    @State var isSettingsTapped: Bool = false
    
    var body: some View {
        //GeometryReader { geometry in
            ScrollView {
                HStack {
                    Spacer()
                    Button(action: {
                        isSettingsTapped = true
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                HStack {
                    VStack {
                        Text(rate)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color("light_main_color"))
                            .cornerRadius(10)
                        Text("⭐")
                            .font(.subheadline)
                            .foregroundColor(Color("light_main_color"))
                    }
                    .padding()
                    
                    VStack {
                        Text(cntRevie)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color("light_main_color"))
                            .cornerRadius(10)
                        Text("💬")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                Text(username)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(status)
                    .font(.custom("SourceSansPro-Regular", size: 18))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Действие при нажатии на кнопку "Написать"
                }) {
                    Text("Написать")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color("main_color"))
                        .cornerRadius(15)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 100)
                
                
                VStack(alignment: .leading) {
//                    HStack {
//                        Text("📍")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                            .padding(.horizontal, -15)
//                        Text(city)
//                            .fontWeight(.bold)
//                            .font(.system(size: 18))
//                    }
                    
                    //.padding()
                    Text("Описание")
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 5)
                    
                    Text(description)
                        .fontWeight(.regular)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .background(Color("light_main_color"))
                        //.frame(width: geometry.size.width)
                        //.fixedSize(horizontal: false, vertical: true)
                        .cornerRadius(15)
                    
                    HStack {
                        Text("💡")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 0)
                        Text("Мои профессиональные интересы")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                    }
                    .padding(.vertical, 10)
                    
                    VStack {
                        Text("list")
                            .padding(.horizontal, 5)
                    }
                    
                    HStack {
                        Text("🎓")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 0)
                        Text("Образование")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                    }
                    .padding(.vertical, 10)
                    
                    VStack {
                        Text("list")
                            .padding(.horizontal, 5)
                    }
                    
                    HStack {
                        Text("💼")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 0)
                        Text("Место работы")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                    }
                    .padding(.vertical, 10)
                    
                    VStack {
                        Text("list")
                            .padding(.horizontal, 5)
                    }
                    //Spacer()
                    .padding(.vertical, 10)
                    Divider()
                    Text("Отзывы")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .padding(.horizontal, -15)
                        .padding()
                    
                    VStack {
                        Text("list")
                            //.padding(.horizontal, 5)
                    }
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .padding()
            .fullScreenCover(isPresented: $isSettingsTapped) {
                SettingsView()
            }
        }
    }
//}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

