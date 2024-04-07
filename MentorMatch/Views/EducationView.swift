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
    
    
    @ObservedObject var viewModel = AuthFirebase()
//    let user = viewModel.getUser() ?? UserM()
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        VStack {
            FieldView(isError: false, isError2: false, maxLength: 239, labelText: "образование", type: "settings", prevText: user.education?.place ?? "", keyboardType: .default, text: $educationPlace)
                .padding(.top, 15)
            FieldView(isError: false, isError2: false, maxLength: 239, labelText: "степень", type: "settings", prevText: user.education?.degree  ?? "", keyboardType: .default, text: $educationLevel)
            
            HStack {
                FieldView(isError: false, isError2: false, maxLength: 239, labelText: "год начала", type: "settings", prevText: user.education?.startYear  ?? "", keyboardType: .numberPad, text: $educationStartYear)
                
                FieldView(isError: false, isError2: false, maxLength: 239, labelText: "год окончания", type: "settings", prevText: user.education?.endYear  ?? "", keyboardType: .numberPad, text: $educationEndYear)
            }
            
            Spacer()
            ButtonView(title: "сохранить",  color: "main_color") {
                viewModel.saveEducationInfo(email: user.email, newEducationData: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear))
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "образование"))
//        .sheet(isPresented: $isYearPickerPresented) {
//            YearPicker(start: 2000, end: 2020)
//                .onDisappear {
//                    // Обновляем выбранный год начала образования
//                    startYear = selectedYearIndex
//                }
//        }
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
