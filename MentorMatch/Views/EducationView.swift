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
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isBack.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    .foregroundColor(.black)
                })
                
                Spacer()
            }
            
            SettingsFieldView(maxLength: 0, labelText: "Образование", prevText: "ВШЭ")
                .padding(.top, 15)
            SettingsFieldView(maxLength: 0, labelText: "Имя", prevText: "Таисия")
            HStack {
                SettingsFieldView(maxLength: 0, labelText: "Год начала", prevText: "2021")
                SettingsFieldView(maxLength: 0, labelText: "Год окончания", prevText: "2025")
            }
            Spacer()
            ButtonView(title: "Сохранить",  color: "main_color") {
                isSaveEducation.toggle()
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 15)
        }
        .padding(.top, 5)
        .fullScreenCover(isPresented: $isSaveEducation) {
            // save
            SettingsView()
        }
        .fullScreenCover(isPresented: $isBack) {
            SettingsView()
        }
        .navigationBarHidden(false)
    }
}

#Preview {
    EducationView()
}
