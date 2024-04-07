//
//  RegistrationEdView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 12.03.2024.
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
    @State private var workPlace: String = ""
    @State private var position: String = ""
    @State private var workStartYear: String = ""
    @State private var workEndYear: String = ""
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var hasEmptyFields: Bool = false
    
    private let user = UserM()
    
    
    var body: some View {
        //        HStack {
        //            Text(firstName + lastName + email + password)
        //        }
        VStack {
            FieldView(isError: hasEmptyFields && workPlace.isEmpty,isError2: hasEmptyFields && workPlace.isEmpty,maxLength: 239, labelText: "место работы", type: "preUsual", prevText: "введите название места работы", keyboardType: .default, text: $workPlace)
                .padding(.top, 15)
            FieldView(isError: hasEmptyFields && position.isEmpty,isError2: hasEmptyFields && position.isEmpty,maxLength: 239, labelText: "должность", type: "preUsual", prevText: "введите должность", keyboardType: .default, text: $position)
            
            HStack {
                FieldView(isError: hasEmptyFields && workStartYear.isEmpty,isError2: hasEmptyFields && workStartYear.isEmpty,maxLength: 239, labelText: "год начала", type: "digitals", prevText: "введите год", keyboardType: .numberPad, text: $workStartYear)
                
                FieldView(isError: hasEmptyFields && workEndYear.isEmpty,isError2: hasEmptyFields && workEndYear.isEmpty,maxLength: 239, labelText: "год окончания", type: "digitals", prevText: "введите год", keyboardType: .numberPad, text: $workEndYear)
            }
            
            
            Spacer()
            ButtonView(title: "далее",  color: "main_color") {
                //isNext.toggle()
                if workPlace.isEmpty || position.isEmpty || workStartYear.isEmpty || workEndYear.isEmpty || (workStartYear > workEndYear){
                    hasEmptyFields = true
                } else {
                    isNext.toggle()
                }
                
                
                //                signUp(email: email, password: password)
//                                authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: workPlace, position: position, startYear: workStartYear, endYear: workEndYear), expertises: [Expertise(name: "lala", rating: 5, isChecked: true), Expertise(name: "blabla", rating: 5, isChecked: true)]) { result in
//                                    switch result {
//                                    case (.success(_)) :
//                                        isNext = true
//                                    case(.failure(let error)):
//                                        //authFirebase.errorMessage = error.errorMessage
//                                        alertMessage = error.errorMessage
//                                        isAlertShow = true
//                                    }
//                                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                //                                leading: CustomBackButton(text: ""),
                trailing:  Button(action: {
                    isNext.toggle()
                    workPlace = ""
                    position = ""
                    workStartYear  = ""
                    workEndYear  = ""
                    //presentationMode.wrappedValue.dismiss()
                }) {
                    Text("пропустить")
                        .foregroundColor(Color("main_color"))
                }
            )
            .navigationDestination(
                isPresented: $isNext) {
                    //                    TabBar()
                    RegistrationExpertiseView(firstName: firstName, lastName: lastName, email: email, password: password, educationPlace: educationPlace, educationLevel: educationLevel, educationStartYear: educationStartYear, educationEndYear: educationEndYear, workPlace: workPlace, position: position, workStartYear: workStartYear, workEndYear: workEndYear)
                }
                .padding(.horizontal, 100)
                .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .alert(isPresented: $isAlertShow) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RegistrationEdView(firstName: "", lastName: "", email: "", password: "")
}
