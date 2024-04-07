//
//  ExperienceView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 11.03.2024.
//

import Foundation
import SwiftUI

struct ExperienceView: View {
    @State var isSaveEducation: Bool = false
    @State var isBack: Bool = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel = AuthFirebase()
   
    
    @State private var workPlace: String = ""
    @State private var workLevel: String = ""
    @State private var workStartYear: String = ""
    @State private var workEndYear: String = ""
    
    @State private var errorMessage: String = ""
    
    @State private var hasEmptyFields: Bool = false
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        VStack {
            
            FieldView(isError: false, isError2: false, maxLength: 239, labelText: "место работы", type: "settings", prevText: user.workExperience?.companyName  ?? "", keyboardType: .default, text: $workPlace)
                .padding(.top, 15)
            FieldView(isError: false, isError2: false, maxLength: 239, labelText: "должность", type: "settings", prevText: user.workExperience?.position  ?? "", keyboardType: .default, text: $workLevel)
            HStack {
                FieldView(isError: false, isError2: false, maxLength: 239, labelText: "год начала", type: "settings", prevText: user.workExperience?.startYear  ?? "", keyboardType: .numberPad, text: $workStartYear)
                FieldView(isError: false, isError2: false, maxLength: 239, labelText: "год окончания", type: "settings", prevText: user.workExperience?.endYear ?? "", keyboardType: .numberPad, text: $workEndYear)
            }
            Spacer()
            if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
            ButtonView(title: "сохранить",  color: "main_color") {
//                isSaveEducation.toggle()
               
                
                if workPlace.isEmpty || workLevel.isEmpty || workStartYear.isEmpty || workEndYear.isEmpty {
                    hasEmptyFields = true
                } else {
                    if let startYear = Int(workStartYear), let endYear = Int(workEndYear) {
                        if startYear <= endYear {
                            viewModel.saveWorkInfo(email: user.email, newWorkData: WorkExperience(companyName: workPlace, position:workLevel, startYear: workStartYear, endYear: workEndYear))
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            // Показываем ошибку
                            errorMessage = "Год окончания опыта работы должен быть больше или равен году начала"
                        }
                    } else {
                        // Если введены некорректные годы
                        errorMessage = "Некорректно введены годы начала и окончания работы"
                    }
                }
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
            
        }
            .onAppear {
                let user = viewModel.getUser() ?? UserM()
                workPlace  = (user.workExperience?.companyName ?? "")
                workLevel  = (user.workExperience?.position ?? "")
                workStartYear  = (user.workExperience?.startYear ?? "")
                workEndYear  = (user.workExperience?.endYear ?? "")
            }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "опыт"))
    }
}

#Preview {
    ExperienceView()
}
