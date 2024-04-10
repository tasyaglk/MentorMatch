//
//  RegistrationViewExpertise.swift
//  MentorMatch
//
//  Created by Тася Галкина on 20.03.2024.
//


import Foundation
import SwiftUI

struct RegistrationExpertiseView: View {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let educationPlace: String
    let educationLevel: String
    let educationStartYear: String
    let educationEndYear: String
    let workPlace: String
    let position: String
    let workStartYear: String
    let workEndYear: String
    
    @State var isNext: Bool = false
    @EnvironmentObject var authFirebase: AuthFirebase
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    @State var expertises: [Expertise] = []
    @State private var isSkillsEmptyAlertShown = false
    
    private let user = UserM()
    
    var body: some View {
        VStack {
            VStack {
                ForEach(expertises.indices, id: \.self) { index in
                    ExpertiseRowView(expertise: $expertises[index])
                }
            }
            .padding(.horizontal)
            .listStyle(GroupedListStyle())
            .background(Color.white)
            .scrollContentBackground(.hidden)
        }
        
        Spacer()
        
        ButtonView(title: "далее", color: "main_color") {
            
            let allSkillsSelected = !expertises.contains { $0.isChecked }
            
            // Если какой-либо из навыков не выбран, выводим сообщение об ошибке
            if allSkillsSelected {
                isSkillsEmptyAlertShown = true
                alertMessage = "Необходимо выбрать навыки"
                return // Прерываем выполнение функции, чтобы данные не сохранялись
            }
            
            
            isNext.toggle()
            authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: workPlace, position: position, startYear: workStartYear, endYear: workEndYear), expertises: expertises) { result in
                switch result {
                case (.success(_)) :
                    isNext = true
                case(.failure(let error)):
                    alertMessage = error.errorMessage
                    isAlertShow = true
                }
            }
            
        }
        
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            trailing:  Button(action: {
                isNext.toggle()
                expertises = []
                authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: workPlace, position: position, startYear: workStartYear, endYear: workEndYear), expertises: expertises) { result in
                    switch result {
                    case (.success(_)) :
                        isNext = true
                    case(.failure(let error)):
                        alertMessage = error.errorMessage
                        isAlertShow = true
                    }
                }
            }) {
                Text("пропустить")
                    .foregroundColor(Color("main_color"))
            }
        )
        .navigationDestination(
            isPresented: $isNext) {
                TabBar()
            }
        
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
            .padding(.top, 5)
            .alert(isPresented: $isAlertShow) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isSkillsEmptyAlertShown) {
                Alert(title: Text("Предупреждение"),
                      message: Text("Необходимо выбрать навыки"),
                      dismissButton: .default(Text("OK")) {
                    print("OK button pressed")
                    // Этот блок выполнится при нажатии на кнопку "ОК" в алерте
                    self.isSkillsEmptyAlertShown = false // Устанавливаем значение в false после нажатия кнопки "ОК"
                }
                )
                
            }
            .onAppear {
                self.expertises = authFirebase.createExpertises()
            }
        
        
    }
}
