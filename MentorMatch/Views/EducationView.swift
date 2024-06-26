//
//  EducationView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct EducationView: View {
    @State private var isYearPickerPresented = false
    @Environment(\.presentationMode) private var presentationMode
    
    @State  var educationPlace: String = ""
    @State  var educationLevel: String = ""
    @State  var educationStartYear: String = ""
    @State  var educationEndYear: String = ""
    @State private var errorMessage: String = ""
    @State private var hasEmptyFields: Bool = false
    
    @ObservedObject var viewModel = AuthFirebase()
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        VStack {
            FieldView(isError: hasEmptyFields && educationPlace.isEmpty,isError2: hasEmptyFields && educationPlace.isEmpty,maxLength: 239, labelText: "образование", type: "settings", prevText: user.education?.place ?? "", keyboardType: .default, text: $educationPlace)
                .padding(.top, 15)
            FieldView(isError: hasEmptyFields && educationLevel.isEmpty,isError2: hasEmptyFields && educationLevel.isEmpty, maxLength: 239, labelText: "специализация", type: "settings", prevText: user.education?.degree  ?? "", keyboardType: .default, text: $educationLevel)
            
            HStack {
                FieldView(isError: hasEmptyFields && educationStartYear.isEmpty,isError2: hasEmptyFields && educationStartYear.isEmpty,maxLength: 239, labelText: "год начала", type: "digitals", prevText: user.education?.startYear  ?? "", keyboardType: .numberPad, text: $educationStartYear)
                
                FieldView(isError: hasEmptyFields && educationEndYear.isEmpty,isError2: hasEmptyFields && educationEndYear.isEmpty,maxLength: 239, labelText: "год окончания", type: "digitals", prevText: user.education?.endYear  ?? "", keyboardType: .numberPad, text: $educationEndYear)
            }
            
            Spacer()
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }
            ButtonView(title: "сохранить",  color: "main_color") {
                if educationLevel.isEmpty || educationPlace.isEmpty || educationStartYear.isEmpty || educationEndYear.isEmpty  {
                    hasEmptyFields = true
                } else {
                    if let startYear = Int(educationStartYear), let endYear = Int(educationEndYear) {
                        if startYear <= endYear {
                            viewModel.saveEducationInfo(email: user.email, newEducationData: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear))
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            errorMessage = "Год окончания образования должен быть больше или равен году начала"
                        }
                    } else {
                        errorMessage = "Некорректно введены годы начала и окончания образования"
                    }
                }
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "образование"))
        .onAppear {
            let user = viewModel.getUser() ?? UserM()
            educationPlace  = (user.education?.place ?? "")
            educationLevel  = (user.education?.degree ?? "")
            educationStartYear  = (user.education?.startYear ?? "")
            educationEndYear  = (user.education?.endYear ?? "")
        }
    }
}


#Preview {
    EducationView()
}
