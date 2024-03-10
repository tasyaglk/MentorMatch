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
    
    var body: some View {
        VStack {
            
            SettingsFieldView(maxLength: 239, labelText: "место работы", prevText: "me")
                .padding(.top, 15)
            SettingsFieldView(maxLength: 239, labelText: "должность", prevText: "ceo")
            HStack {
                SettingsFieldView(maxLength: 239, labelText: "год начала", prevText: "2003")
                SettingsFieldView(maxLength: 239, labelText: "год окончания", prevText: "наст время")
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
        .navigationBarItems(leading: CustomBackButton(text: "опыт"))
    }
}

#Preview {
    ExperienceView()
}
