//
//  SettingsFieldView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct SettingsFieldView: View {
    
    let maxLength: Int
    let labelText: String
    let prevText: String
    
    @State private var text: String
    
    init(maxLength: Int, labelText: String, prevText: String) {
        self.text = prevText
        self.maxLength = maxLength
        self.labelText = labelText
        self.prevText = prevText
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(labelText)
                .font(.headline)
                .foregroundColor(.gray)
            
            TextField(prevText, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 8))
                .cornerRadius(15)
                .onChange(of: text) { newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
            if maxLength != 0 {
                Text("\(text.count)/\(maxLength)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
        .padding(.horizontal, 15)
        //.padding(.vertical, 2)
    }
}


struct SettingsField_Previews: PreviewProvider {
    static var previews: some View {
        SettingsFieldView(maxLength: 20, labelText: "Описание", prevText: "Таисия")
//            .previewLayout(.sizeThatFits)
//            .padding()
    }
}


