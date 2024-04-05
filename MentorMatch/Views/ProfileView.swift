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
    
    @ObservedObject var viewModel = AuthFirebase()
//    t4@t.ru
//    tttttt
    
    
    var body: some View {
        let userr = viewModel.getUser() ?? UserM()
        
        ScrollView {
            HStack {
                Spacer()
                Button(action: {
                    isSettingsTapped = true
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                }
//                .navigationBarHidden(true)
//                .navigationDestination(
//                    isPresented: $isSettingsTapped) {
//                        SettingsView()
//                    }
            }
            .padding()
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.top, 20)
            
            //                HStack {
            //                    VStack {
            //                        Text(rate)
            //                            .fontWeight(.bold)
            //                            .font(.system(size: 18))
            //                            .foregroundColor(.black)
            //                            .padding(.horizontal, 10)
            //                            .padding(.vertical, 5)
            //                            .background(Color("light_main_color"))
            //                            .cornerRadius(10)
            //                        Text("⭐")
            //                            .font(.subheadline)
            //                            .foregroundColor(Color("light_main_color"))
            //                    }
            //                    .padding()
            //
            //                    VStack {
            //                        Text(cntRevie)
            //                            .fontWeight(.bold)
            //                            .font(.system(size: 18))
            //                            .padding(.horizontal, 10)
            //                            .padding(.vertical, 5)
            //                            .background(Color("light_main_color"))
            //                            .cornerRadius(10)
            //                        Text("💬")
            //                            .font(.subheadline)
            //                            .foregroundColor(.gray)
            //                    }
            //                    .padding()
            //                }
            
            Text(userr.firstName + " " + userr.lastName)
                .font(.title)
                .fontWeight(.bold)
            
            Text(userr.status)
                .font(.custom("SourceSansPro-Regular", size: 18))
                .foregroundColor(.gray)
            
//            Button(action: {
//                // Действие при нажатии на кнопку "Написать"
//            }) {
//                Text("Написать")
//                    .fontWeight(.bold)
//                    .font(.system(size: 20))
//                    .foregroundColor(.black)
//                    .padding()
//                    .background(Color("main_color"))
//                    .cornerRadius(15)
//            }
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
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)
                
                
                Text(userr.description)
                    .fontWeight(.regular)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(Color("light_main_color"))
                //.frame(width: geometry.size.width)
                //.fixedSize(horizontal: false, vertical: true)
                    .cornerRadius(15)
                // if userr.expertise != nil {
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
                if userr.expertise != nil {
                    VStack {
                        ForEach(userr.expertise!) { expertiseItem in
                            // Вывод экспертиз
                            if expertiseItem.isChecked == true {
                                HStack {
                                    Text("\(expertiseItem.name)")
                                        //.padding(.horizontal, 5)
                                    
                                    Spacer()
                                    ForEach(1..<6) { index in
                                        Image(systemName: index <= expertiseItem.rating ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                            
                        }
                        //.padding(.leading, 5)
                    }
                } else {
                    VStack {
                        Text(":|")
                    }
                    //.padding(.horizontal, 5)
                }
                
                //}
                
                
                
                
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
                
                if userr.education!.place == "" {
                    VStack {
                        Text(":|")
                    }
                    //.padding(.horizontal, 5)
                } else {
                    VStack {
                        EducationAndExperienceView(label1: userr.education?.place ?? "", label2: userr.education?.degree ?? "", label3: userr.education?.startYear ?? "", label4: userr.education?.endYear ?? "")
                            .padding(.horizontal, 5)
                    }
                    //.padding(.horizontal, 5)
                    
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
                
                if userr.workExperience!.companyName == "" {
                    Text(":|")
                } else {
                    VStack {
                        EducationAndExperienceView(label1: userr.workExperience?.companyName ?? "", label2: userr.workExperience?.position ?? "", label3: userr.workExperience?.startYear ?? "", label4: userr.workExperience?.endYear ?? "")
                            .padding(.horizontal, 5)
                    }
                    //.padding(.vertical, 10)
                    
                }
                
                //                    VStack {
                //                        EducationAndExperienceView(label1: "Me", label2: "CEO", label3: "2003", label4: "2025")
                //                            .padding(.horizontal, 5)
                //                    }
                //Spacer()
                
                //                    Divider()
                //                    Text("Отзывы")
                //                        .fontWeight(.bold)
                //                        .font(.system(size: 18))
                //                        .padding(.horizontal, -15)
                //                        .padding()
                //
                //                    VStack {
                //                        Text("list")
                //                            //.padding(.horizontal, 5)
                //                    }
            }
            //Spacer()
        }
        .navigationBarHidden(true)
        .navigationDestination(
            isPresented: $isSettingsTapped) {
                SettingsView()
            }
//        NavigationLink(destination: SettingsView(), isActive: $isSettingsTapped) {
//            EmptyView()
//        }
//        .hidden()
        .scrollIndicators(.hidden)
        .padding()
        //            .fullScreenCover(isPresented: $isSettingsTapped) {
        //                SettingsView()
        //            }
    }
}
//}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

