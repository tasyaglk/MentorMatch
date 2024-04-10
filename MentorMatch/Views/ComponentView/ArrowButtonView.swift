//
//  ArrowButtonView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct ArrowButtonView: View {
    var buttonClicked: (() -> Void)?
    var title: String
    
    var body: some View {
        Button(action: {
            buttonClicked?()
        }, label: {
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 15)
                Spacer()
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.trailing, 15)
            }
        })
        .padding(.top, 2)
    }
    
    init(title: String, height: CGFloat = 70, color: String = "main_color", buttonClicked: (() -> Void)? = nil) {
        self.title = title
        self.buttonClicked = buttonClicked
    }
}

struct ArrowButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButtonView(title: "Войти")
    }
}

