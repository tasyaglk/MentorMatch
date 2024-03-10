//
//  EducationView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct EducationView: View {
    @State var isSaveEducation: Bool = false
    @State var isBack: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            SettingsFieldView(maxLength: 239, labelText: "образование", prevText: "ВШЭ")
                .padding(.top, 15)
            SettingsFieldView(maxLength: 239, labelText: "имя", prevText: "Таисия")
            HStack {
                SettingsFieldView(maxLength: 239, labelText: "год начала", prevText: "2021")
                SettingsFieldView(maxLength: 239, labelText: "год окончания", prevText: "2025")
            }
            Spacer()
            ButtonView(title: "сохранить",  color: "main_color") {
                isSaveEducation.toggle()
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "образование"))
    }
}

#Preview {
    EducationView()
}
