//
//  CustomBackButton.swift
//  MentorMatch
//
//  Created by Тася Галкина on 11.03.2024.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var text: String
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
    }
    
    init(text: String) {
        self.text = text
    }
}

struct Back: PreviewProvider {
    static var previews: some View {
        CustomBackButton(text: "lol")
    }
}
