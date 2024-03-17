//
//  RegistrationWorkView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 16.03.2024.
//

import Foundation
import SwiftUI

struct RegistrationWorkView: View {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let educationPlace: String
    let educationLevel: String
    let educationStartYear: String
    let educationEndYear: String
    
    @State var isNext: Bool = false
    // @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var authFirebase: AuthFirebase
    @State private var companyName: String = ""
    @State private var position: String = ""
    @State private var workStartYear: String = ""
    @State private var workEndYear: String = ""
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    
    private let user = UserM()
    
    func signUp(email: String, password: String) {
        authFirebase.signUp(email: email, password: password) { result in
            switch result {
            case (.success(_)) :
                isNext = true
                //isSignUp =  true
                //authFirebase.insertNewUser(email: email)
            case(.failure(let error)):
                alertMessage = error.errorMessage
                isAlertShow = true
            }
        }
    }
    
    var body: some View {
//        HStack {
//            Text(firstName + lastName + email + password)
//        }
        
        VStack {
            FieldView(maxLength: 239, labelText: "место работы", type: "preUsual", prevText: "введите место работы", keyboardType: .default, text: $companyName)
                .padding(.top, 15)
            FieldView(maxLength: 239, labelText: "должность", type: "preUsual", prevText: "введите должность", keyboardType: .default, text: $position)
            
            HStack {
                FieldView(maxLength: 239, labelText: "год начала", type: "preUsual", prevText: "введите год", keyboardType: .numberPad, text: $workStartYear)
                
                FieldView(maxLength: 239, labelText: "год окончания", type: "preUsual", prevText: "введите год", keyboardType: .numberPad, text: $workEndYear)
            }
            
            
            Spacer()
            ButtonView(title: "далее",  color: "main_color") {
                //isNext.toggle()
               /// signUp(email: email, password: password)
                authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: companyName, position: position, startYear: workStartYear, endYear: workEndYear), expertise: Expertise(name: "?", rating: 5, isChecked: true)) { result in
                    switch result {
                    case (.success(_)) :
                        isNext = true
                    case(.failure(let error)):
                        //authFirebase.errorMessage = error.errorMessage
                        alertMessage = error.errorMessage
                        isAlertShow = true
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
//                leading: CustomBackButton(text: ""),
                trailing:  Button(action: {
                    isNext.toggle()
                    //presentationMode.wrappedValue.dismiss()
                    signUp(email: email, password: password)
                    authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: "", position: "", startYear: "", endYear: ""), expertise: Expertise(name: "?", rating: 5, isChecked: true)) { result in
                        switch result {
                        case (.success(_)) :
                            isNext = true
                        case(.failure(let error)):
                            //authFirebase.errorMessage = error.errorMessage
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
        }
        .padding(.top, 5)
        .alert(isPresented: $isAlertShow) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        //        .navigationBarBackButtonHidden(true)
        //        .navigationBarItems(leading: CustomBackButton(text: "образование"))
        //        .sheet(isPresented: $isYearPickerPresented) {
        //            YearPicker(start: 2000, end: 2020)
        //                .onDisappear {
        //                    // Обновляем выбранный год начала образования
        //                    startYear = selectedYearIndex
        //                }
        //        }
    }
}

//#Preview {
//    RegistrationWorkView(firstName: "", lastName: "", email: "", password: "")
//}
