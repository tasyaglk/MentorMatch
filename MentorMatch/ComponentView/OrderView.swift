//
//  OrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 05.04.2024.
//

import Foundation
import SwiftUI

struct OrderView: View {
    
    var order: Order
    @State var isActive: Bool
    @ObservedObject private var viewModel = AuthFirebase()
    
    var body: some View  {
        HStack {
//            ScrollView(.horizontal) {
                HStack {
                    ForEach(order.selectedSkills, id: \.self) { skill in
                        Text(skill)
                            .padding(8)
                            .background(Color("main_color"))
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .padding(.horizontal, 4)
                    }
                }
//            }
            
            Spacer()
            
            Toggle(isOn: $isActive, label: {
            })
            .toggleStyle(SwitchToggleStyle(tint: isActive ? Color("main_color") : .gray))
            .onChange(of: isActive) { newValue in
                isActive.toggle()
                viewModel.updateOrderStatusInUserDocument(orderID: order.id ?? "", isDone: isActive)
            }
        }
    }
}
