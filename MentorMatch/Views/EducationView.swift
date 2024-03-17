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
    @State private var educationPlace: String = ""
    @State private var educationLevel: String = ""
    @State private var educationStartYear: String = ""
    @State private var educationEndYear: String = ""
    
    private let user = UserM()
    
    var body: some View {
        VStack {
            FieldView(maxLength: 239, labelText: "образование", type: "settings", prevText: user.education?.place ?? "", keyboardType: .default, text: $educationPlace)
                .padding(.top, 15)
            FieldView(maxLength: 239, labelText: "степень", type: "settings", prevText: user.education?.degree  ?? "", keyboardType: .default, text: $educationLevel)
            
            HStack {
                FieldView(maxLength: 239, labelText: "год начала", type: "settings", prevText: user.education?.startYear  ?? "", keyboardType: .numberPad, text: $educationStartYear)
                
                FieldView(maxLength: 239, labelText: "год окончания", type: "settings", prevText: user.education?.endYear  ?? "", keyboardType: .numberPad, text: $educationEndYear)
            }
            
            Spacer()
            ButtonView(title: "сохранить",  color: "main_color") {
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
    }
}


#Preview {
    EducationView()
}
