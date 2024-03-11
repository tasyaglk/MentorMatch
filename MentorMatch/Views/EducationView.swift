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
            
            FieldView(maxLength: 239, labelText: "образование", prevText: "ВШЭ", type: "settings")
                .padding(.top, 15)
            FieldView(maxLength: 239, labelText: "имя", prevText: "Таисия", type: "settings")
            HStack {
                FieldView(maxLength: 239, labelText: "год начала", prevText: "2021", type: "settings")
                FieldView(maxLength: 239, labelText: "год окончания", prevText: "2025", type: "settings")
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
