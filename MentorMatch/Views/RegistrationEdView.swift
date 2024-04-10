//
//  RegistrationEdView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 12.03.2024.
//

import Foundation
import SwiftUI


struct RegistrationEdView: View {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    @State var isNext: Bool = false
    // @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var authFirebase: AuthFirebase
    @State private var educationPlace: String = ""
    @State private var educationLevel: String = ""
    @State private var educationStartYear: String = ""
    @State private var educationEndYear: String = ""
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    @State private var hasEmptyFields: Bool = false
    @State private var errorMessage: String = ""
    
    
    private let user = UserM()
    
    
    var body: some View {
        ScrollView {
            VStack {
                FieldView(isError: hasEmptyFields && educationPlace.isEmpty,isError2: hasEmptyFields && educationPlace.isEmpty,maxLength: 239, labelText: "образование", type: "preUsual", prevText: "введите название учебного заведения", keyboardType: .default, text: $educationPlace)
                    .padding(.top, 15)
                FieldView(isError: hasEmptyFields && educationLevel.isEmpty,isError2: hasEmptyFields && educationLevel.isEmpty,maxLength: 239, labelText: "специализация", type: "preUsual", prevText: "введите полученную специализацию", keyboardType: .default, text: $educationLevel)
                
                HStack {
                    FieldView(isError: hasEmptyFields && educationStartYear.isEmpty,isError2: hasEmptyFields && educationStartYear.isEmpty,maxLength: 239, labelText: "год начала", type: "digitals", prevText: "введите год", keyboardType: .numberPad, text: $educationStartYear)
                    
                    FieldView(isError: hasEmptyFields && educationEndYear.isEmpty,isError2: hasEmptyFields && educationEndYear.isEmpty,maxLength: 239, labelText: "год окончания", type: "digitals", prevText: "введите год", keyboardType: .numberPad, text: $educationEndYear)
                }
                
                Spacer()
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }
                
                ButtonView(title: "далее",  color: "main_color") {
                    if educationLevel.isEmpty || educationPlace.isEmpty || educationStartYear.isEmpty || educationEndYear.isEmpty  {
                        hasEmptyFields = true
                    } else {
                        if let startYear = Int(educationStartYear), let endYear = Int(educationEndYear) {
                            if startYear <= endYear {
                                isNext.toggle()
                            } else {
                                errorMessage = "Год окончания образования должен быть больше или равен году начала"
                            }
                        } else {
                            errorMessage = "Некорректно введены годы начала и окончания образования"
                        }
                    }
                }
                .padding(.bottom, 5)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    trailing:  Button(action: {
                        isNext.toggle()
                        educationPlace = ""
                        educationLevel = ""
                        educationStartYear  = ""
                        educationEndYear  = ""
                    }) {
                        Text("пропустить")
                            .foregroundColor(Color("main_color"))
                    }
                )
                .navigationDestination(isPresented: $isNext) {
                    RegistrationWorkView(firstName: firstName, lastName: lastName, email: email, password: password, educationPlace: educationPlace, educationLevel: educationLevel, educationStartYear: educationStartYear, educationEndYear: educationEndYear)
                }
                .padding(.horizontal, 100)
                .padding(.bottom, 15)
            }
        }
        .padding(.top, 5)
        .alert(isPresented: $isAlertShow) {
            Alert(title: Text("Ошибка"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RegistrationEdView(firstName: "", lastName: "", email: "", password: "")
}
