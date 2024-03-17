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
    
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var status: String = ""
    @State private var description: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        let user = viewModel.getUser() ?? UserM()
        ScrollView {
            //            HStack {
            //                Spacer()
            //                Button(action: {
            //                    isSave.toggle()
            //                    //presentationMode.wrappedValue.dismiss()
            //                    viewModel.selectedTab = 3
            //                }) {
            //                    Text("Сохранить")
            //                        .foregroundColor(Color("main_color"))
            //                        .font(.system(size: 18))
            //                        .padding(.trailing, 15)
            //                }
            //            }
            // Фотография с возможностью замены
//            Button(action: {
//                // Действие при нажатии на фотографию
//                // Здесь можно добавить код для выбора новой фотографии из фотопленки
//            }) {
//                profileImage
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
//                    .padding()
//            }
            
            // Ячейка для имени
            VStack {
                
                FieldView(maxLength: 239, labelText: "имя", type: "settings", prevText: user.firstName, keyboardType: .default, text: $firstName)
                    //.padding(.top, 15)
                FieldView(maxLength: 239, labelText: "фамилия", type: "settings", prevText: user.lastName, keyboardType: .default, text: $lastName)
                FieldView(maxLength: 20, labelText: "Статус", type: "settings", prevText: user.status, keyboardType: .default, text: $status)
                FieldView(maxLength: 20, labelText: "Описание", type: "settings", prevText: user.description, keyboardType: .default, text: $description)
                
                ArrowButtonView(title: "навыки") {
                    isExpertise.toggle()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton(text: ""))
                .navigationDestination(
                    isPresented: $isExpertise) {
                        ExpertiseView()
                    }
                .padding(.top, 10)
                ArrowButtonView(title: "образование") {
                    isEducation.toggle()
                }
                .navigationBarBackButtonHidden(true)
                //.navigationBarItems(leading: CustomBackButton(text: ""))
                .navigationBarItems(
                                    leading: CustomBackButton(text: ""),
                                    trailing:  Button(action: {
                                        isSave.toggle()
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
                    isLogOut.toggle()
                    presentationMode.wrappedValue.dismiss()
                    //// костыль
                    
                }
                .padding(.bottom, 5)
                .padding(.horizontal, 100)
                
            }
        }
        //        .fullScreenCover(isPresented: $isSave) {
        //            TabBar()
        //        }
        //        .fullScreenCover(isPresented: $isEducation) {
        //            EducationView()
        //        }
        
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
