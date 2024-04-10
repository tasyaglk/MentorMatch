//
//  OrdersView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 04.04.2024.
//

import Foundation
import SwiftUI

struct OrdersView: View {
    @State private var selectedSkills: [String] = []
    @State private var comment: String = ""
    @State private var searchText: String = ""
    @State private var isDropdownVisible = false
    @State private var isPublic = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthFirebase
    @State var allSkills = [String]()
    @State var allOrders = [Order]()
    @State var isOut = false
    @State var isActive = false
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        ScrollView {
            if viewModel.orders.isEmpty {
                Text("Заказов пока нет")
            } else {
                HStack {
                    Text("Описание заказа")
                    Spacer()
                    Text("Статус заказа")
                }
                .padding(.horizontal)
                Divider()
                VStack(alignment: .leading) {
                    
                    ForEach(viewModel.orders, id: \.self) { order in
                        if order.byUserEmail == user.email{
                            if viewModel.isOrderHasSkills(selectedSkills: selectedSkills, order: order) {
                                OrderView(order: order, isActive: order.isActive)
                                
                                    .padding(.horizontal)
                                Divider()
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        .onAppear {
            viewModel.fetchAllOrders()
            allOrders = viewModel.orders.sorted(by: { (firstOrder, secondOrder) -> Bool in
                if firstOrder.isActive == secondOrder.isActive {
                    return true
                } else {
                    return firstOrder.isActive
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:  Button(action: {
                isOut.toggle()
            }) {
                CustomBackButton(text: "заказы")
            }
        )
        .navigationDestination(
            isPresented: $isOut) {
                SettingsView()
            }
    }
}

