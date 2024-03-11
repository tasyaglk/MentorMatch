//
//  ButtonView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    var buttonClicked: (() -> Void)?
    var title: String
    var height: CGFloat
    var color: String

    var body: some View {
        Button(action: {
            buttonClicked?()
        }, label: {
            Text(title)
//                .font(.dl.mainFont())
                .fontWeight(.bold)
                .font(.system(size: 25))
                .foregroundColor(.black)
                .padding()
                .frame(height: height)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color(color))
                .cornerRadius(height / 2)
        })
    }
    
    init(title: String, height: CGFloat = 70, color: String = "main_color", buttonClicked: (() -> Void)? = nil) {
        self.title = title
        self.height = height
        self.color = color
        self.buttonClicked = buttonClicked
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Войти")
    }
}

