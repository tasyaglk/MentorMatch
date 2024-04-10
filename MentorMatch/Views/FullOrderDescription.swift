//
//  FullOrderDescription.swift
//  MentorMatch
//
//  Created by Тася Галкина on 05.04.2024.
//

import Foundation
import SwiftUI

struct FullOrderDescription: View {
    
    var order: Order
    var user: UserM
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(order.comment)
                .fontWeight(.medium)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding(.horizontal, 5)
            
            
            HStack {
                ForEach(order.selectedSkills, id: \.self) { skill in
                    Text(skill)
                        .padding(8)
                        .background(Color("light_main_color"))
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .padding(.horizontal, 4)
                }
            }
            Divider()
            SmallUserView(user: user)
                .padding(.horizontal)
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: ""))
    }
}
