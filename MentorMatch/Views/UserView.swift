//
//  UserView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 05.04.2024.
//

import Foundation
import SwiftUI

struct UserView: View {
    
    @State private var username = "Taisiia Galkina"
    @State private var rate = "5.0"
    @State private var cntRevie = "239"
    @State private var status = "lalala"
    @State private var city = "Москва"
    @State private var description = "Senior"
    @State var isSettingsTapped: Bool = false
    
    @ObservedObject var viewModel = AuthFirebase()
    @StateObject var imageLoader = ImageLoader()
    
    var userr: UserM
    
    var body: some View {
        ScrollView {
//                HStack {
            
        //            .padding()
            HStack {
                Spacer()
                Button(action: {
                    isSettingsTapped = true
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                        .fixedSize()
                }
                //                .navigationBarHidden(true)
                //                .navigationDestination(
                //                    isPresented: $isSettingsTapped) {
                //                        SettingsView()
                //                    }
            }
            //            .padding()
            VStack {
                if userr.photoURL == "" {
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle()) // Делает изображение круглым
                        .frame(width: 150, height: 150) // Устанавливает средний размер
                } else {
                    if let image = imageLoader.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle()) // Делает изображение круглым
                            .frame(width: 150, height: 150) // Устанавливает средний размер
                    } else {
                        Text("Загрузка...")
                            .padding()
                    }
                }
            }
            .onAppear {
                if let url = URL(string: userr.photoURL ?? "") {
                    imageLoader.load(url: url)
                }
            }
        
        Text(userr.firstName + " " + userr.lastName)
            .font(.title)
            .fontWeight(.bold)
        
        if !userr.status.isEmpty {
            Text(userr.status)
                .font(.custom("SourceSansPro-Regular", size: 18))
                .foregroundColor(.gray)
            
                .padding(.vertical, 10)
                .padding(.horizontal, 100)
        }
        
        
        
        VStack(alignment: .leading) {
            Text("Моя почта для связи:)")
                .fontWeight(.medium)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.horizontal, 5)
            Text(userr.email)
                .fontWeight(.regular)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            //                    .background(Color("light_main_color"))
                .cornerRadius(15)
            if !userr.description.isEmpty {
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
                    .cornerRadius(15)
            }
            
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
            let allSkillsSelected = !userr.expertise!.contains { $0.isChecked } 
            if !allSkillsSelected {
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
                }
            } else {
                VStack {
                    Text(":|")
                }
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
            
            if userr.education!.place == "" {
                VStack {
                    Text(":|")
                }
            } else {
                VStack {
                    EducationAndExperienceView(label1: userr.education?.place ?? "", label2: userr.education?.degree ?? "", label3: userr.education?.startYear ?? "", label4: userr.education?.endYear ?? "")
                        .padding(.horizontal, 5)
                }
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
            }
        }
    }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: ""))
        .scrollIndicators(.hidden)
        .padding()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userr: UserM())
    }
}


