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
    
    private let user = UserM()
    
    
    var body: some View {
        //        HStack {
        //            Text(firstName + lastName + email + password)
        //        }
        VStack {
            FieldView(isError: hasEmptyFields && educationPlace.isEmpty,maxLength: 239, labelText: "образование", type: "preUsual", prevText: "введите название учебного заведения", keyboardType: .default, text: $educationPlace)
                .padding(.top, 15)
            FieldView(isError: hasEmptyFields && educationLevel.isEmpty,maxLength: 239, labelText: "степень", type: "preUsual", prevText: "введите полученную степень", keyboardType: .default, text: $educationLevel)
            
            HStack {
                FieldView(isError: hasEmptyFields && educationStartYear.isEmpty,maxLength: 239, labelText: "год начала", type: "preUsual", prevText: "введите год", keyboardType: .numberPad, text: $educationStartYear)
                
                FieldView(isError: hasEmptyFields && educationEndYear.isEmpty,maxLength: 239, labelText: "год окончания", type: "preUsual", prevText: "введите год", keyboardType: .numberPad, text: $educationEndYear)
            }
            
            
            Spacer()
            ButtonView(title: "далее",  color: "main_color") {
                if educationLevel.isEmpty || educationPlace.isEmpty || educationStartYear.isEmpty || educationEndYear.isEmpty {
                    hasEmptyFields = true
                } else {
                    isNext.toggle()
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                //                                leading: CustomBackButton(text: ""),
                trailing:  Button(action: {
                    isNext.toggle()
                    educationPlace = ""
                    educationLevel = ""
                    educationStartYear  = ""
                    educationEndYear  = ""
                    //presentationMode.wrappedValue.dismiss()
                }) {
                    Text("пропустить")
                        .foregroundColor(Color("main_color"))
                }
            )
            .navigationDestination(
                isPresented: $isNext) {
                    RegistrationWorkView(firstName: firstName, lastName: lastName, email: email, password: password, educationPlace: educationPlace, educationLevel: educationLevel, educationStartYear: educationStartYear, educationEndYear: educationEndYear)
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

#Preview {
    RegistrationEdView(firstName: "", lastName: "", email: "", password: "")
}
