//
//  OrdersView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 04.04.2024.
//

import Foundation
import SwiftUI



//struct OrdersView: View {
//    @ObservedObject var viewModel = AuthFirebase()
//    @State var isActive: Bool = false
//    @State private var sortedOrders = [Order]()
//    
//    var user: UserM
//    
//    var body: some View {
////        let user = viewModel.getUser() ?? UserM()
//        ScrollView {
//            
//                VStack(alignment: .leading) {
//                    ForEach(viewModel.strangersOrders, id: \.self) { order in
//                        if order.byUserEmail == viewModel.auth.currentUser?.email {
//                            OrderView(order: order, isActive: order.isActive)
//                        }
//                }
//            }
//        }
////        .onAppear {
//////            viewModel.fetchData()
//////            viewModel.fetchAllsOrders()
//////            viewModel.fetchAllStrangersOrders()
//////            sortedOrders = viewModel.getOrders(email: user.email)
//////            sortedOrders = viewModel.getOrders(email: user.email)
////        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: CustomBackButton(text: "заказы"))
//        //        .navigationBarTitle("Заказы")
//    }
//    
//}
//
//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrdersView(user: UserM())
//    }
//}

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
                            //                                Text(order.byUserEmail)
                            if order.byUserEmail == user.email{
                                if viewModel.zalupa(selectedSkills: selectedSkills, order: order) {
                                    //                                StrangerOrderView(order: order, user: user)
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
            allSkills = viewModel.skillsName
//                            viewModel.fetchData()
//            viewModel.fetchAllStrangersOrders()
            viewModel.fetchAllOrders()
//            viewModel.hui()
            //                strangersOrder = viewModel.strangersOrders
        }
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton(text: "заказы"))
//        .padding(.top, 70)
    }
}
    
    ////struct MentorSearchView_Previews: PreviewProvider {
    ////    static var previews: some View {
    ////        MentorSearchView()
    ////    }
    ////}

