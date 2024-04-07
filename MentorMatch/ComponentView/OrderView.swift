//
//  OrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 05.04.2024.
//

import Foundation
import SwiftUI

struct OrderView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        // Добавьте больше GridItem для управления количеством элементов в строке в зависимости от доступного пространства
    ]
    
    var order: Order
    @State var isActive: Bool
    @ObservedObject private var viewModel = AuthFirebase()
    
    var body: some View  {
        HStack {
//            ScrollView(.horizontal) {
            LazyVGrid(columns: columns) {
                    ForEach(order.selectedSkills, id: \.self) { skill in
                        Text(skill)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color("main_color"))
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .cornerRadius(30)
                    }
                }
//            }
            
//            Spacer()
            
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
