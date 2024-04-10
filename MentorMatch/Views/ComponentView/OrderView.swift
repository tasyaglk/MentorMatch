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
    ]
    
    var order: Order
    @State var isActive: Bool
    @ObservedObject private var viewModel = AuthFirebase()
    
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View  {
        let user = viewModel.getUser() ?? UserM()
            VStack(alignment: .leading) {
                Text(order.comment)
                    .bold()
                
                HStack {
                    
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
                    Toggle(isOn: $isActive, label: {
                    })
                    .toggleStyle(SwitchToggleStyle(tint: isActive ? Color("main_color") : .gray))
                    .onChange(of: isActive) { newValue in
                        isActive.toggle()
                        viewModel.updateOrderStatusInUserDocument(email: user.email, orderID: order.id ?? "", isDone: isActive)
                    }
                }
            }
    }
}
