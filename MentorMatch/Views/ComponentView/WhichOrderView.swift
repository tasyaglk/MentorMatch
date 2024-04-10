//
//  WhichOrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import Foundation
import SwiftUI

struct WhichOrderView: View {
    var order: Order
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Требуемые навыки:")
                    .font(.headline)
                LazyVGrid(columns: columns) {
                    ForEach(order.selectedSkills, id: \.self) { skill in
                        Text(skill)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color("light_main_color"))
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .cornerRadius(30)
                    }
                }
            }
            .padding()
        }
    }
}

