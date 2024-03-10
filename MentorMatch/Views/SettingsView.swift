//
//  SettingsView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var profileImage: Image = Image(systemName: "person")
    //@State private var name: String = "John Doe"
    @State private var isEditName: Bool = false
    @State private var newName: String = ""
    @State var isSave: Bool = false
    @State var isEducation: Bool = false
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button(action: {
                    isSave.toggle()
                    //presentationMode.wrappedValue.dismiss()
                    viewModel.selectedTab = 3
                }) {
                    Text("Сохранить")
                        .foregroundColor(Color("main_color"))
                        .font(.system(size: 18))
                        .padding(.trailing, 15)
                }
            }
            // Фотография с возможностью замены
            Button(action: {
                // Действие при нажатии на фотографию
                // Здесь можно добавить код для выбора новой фотографии из фотопленки
            }) {
                profileImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .padding()
            }
            
            // Ячейка для имени
            VStack {
                SettingsFieldView(maxLength: 0, labelText: "Имя", prevText: "Таисия")
                SettingsFieldView(maxLength: 0, labelText: "Фамилия", prevText: "Галкина")
                SettingsFieldView(maxLength: 20, labelText: "Статус", prevText: "лалала")
                SettingsFieldView(maxLength: 20, labelText: "Описание", prevText: "сеньор девелопер")
                
                ArrowButtonView(title: "навыки") {
                    
                }
                .padding(.top, 10)
                ArrowButtonView(title: "образование") {
                    isEducation.toggle()
                }
                ArrowButtonView(title: "опыт") {
                    
                }
//                ButtonView(title: "Сохранить",  color: "main_color") {
//                        //isLogged.toggle()
//                    }
//                .padding(.horizontal, 100)
//                .padding(.bottom, 5)
            }
        }
        .fullScreenCover(isPresented: $isSave) {
            TabBar()
        }
        .fullScreenCover(isPresented: $isEducation) {
            EducationView()
        }

    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
