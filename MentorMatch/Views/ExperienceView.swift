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
            
            FieldView(maxLength: 239, labelText: "место работы", prevText: "me", type: "settings")
                .padding(.top, 15)
            FieldView(maxLength: 239, labelText: "должность", prevText: "ceo", type: "settings")
            HStack {
                FieldView(maxLength: 239, labelText: "год начала", prevText: "2003", type: "settings")
                FieldView(maxLength: 239, labelText: "год окончания", prevText: "наст время", type: "settings")
            }
            
        }
        .padding(.top, 5)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "опыт"))
    }
}

#Preview {
    ExperienceView()
}
