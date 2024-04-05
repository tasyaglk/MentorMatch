//
//  OrdersView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 04.04.2024.
//

import Foundation
import SwiftUI



struct OrdersView: View {
    @ObservedObject var viewModel = AuthFirebase()
    @State var isActive: Bool = false
    @State private var sortedOrders = [Order]()
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        List {
            ForEach(viewModel.orders) { order in
                VStack(alignment: .leading) {
                    OrderView(order: order, isActive: order.isActive)
//                    HStack {
//                        HStack {
//                            ForEach(order.selectedSkills, id: \.self) { skill in
//                                Text(skill)
//                            }
//                        }
//                        Spacer()                     }
//                        Toggle(isOn: $isActive, label: {
//                            Text("Активный заказ")
//                        })
//                        .toggleStyle(SwitchToggleStyle(tint: isActive ? Color("main_color") : .gray))
//                        .onChange(of: isActive) { newValue in
//                            isActive.toggle()
//                            viewModel.updateOrderStatusInUserDocument(orderID: order.id ?? "", isDone: isActive)
//                        }
                    }
                }
            }
        .onAppear {
            viewModel.getOrders()
//            sortedOrders = orders.sorted { (order1, order2) in
//                            if order1.isActive && !order2.isActive {
//                                return true // Помещаем активные заказы в начало
//                            } else if !order1.isActive && order2.isActive {
//                                return false // Помещаем неактивные заказы после активных
//                            } else {
//                                return order1.id < order2.id // Если оба заказа в одном статусе, сортируем по id
//                            }
//                        }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "заказы"))
//        .navigationBarTitle("Заказы")
        }
        
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: AuthFirebase())
    }
}
