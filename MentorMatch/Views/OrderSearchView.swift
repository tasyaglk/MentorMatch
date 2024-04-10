//
//  OrderSearchView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 12.03.2024.
//

import Foundation
import SwiftUI

struct OrderSearchView: View {
    @State private var selectedSkills: [String] = []
    @State private var comment: String = ""
    @State private var searchText: String = ""
    @State private var isDropdownVisible = false
    @State private var isPublic = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthFirebase
    @State var allSkills = [String]()
    
    var filteredSkills: [String] {
        if searchText.isEmpty {
            return allSkills
        } else {
            return allSkills.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                
                TextField("Необходимые навыки..", text: $searchText)
                    .padding(.vertical, 8)
                    .background(.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        self.isDropdownVisible = true
                    }
            }
            .padding(.horizontal)
            
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(selectedSkills, id: \.self) { skill in
                                Text(skill)
                                    .padding(8)
                                    .background(Color("main_color"))
                                    .foregroundColor(.black)
                                
                                    .cornerRadius(8)
                                    .padding(.horizontal, 4)
                            }
                        }
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.strangersOrders.reversed(), id: \.self) { order in
                                if order.byUserEmail.lowercased() != viewModel.auth.currentUser?.email && order.isActive == true {
                                    let user = viewModel.getUserByEmail(email: order.byUserEmail)
                                    if viewModel.isOrderHasSkills(selectedSkills: selectedSkills, order: order) {
                                        StrangerOrderView(order: order, user: user)
                                            .padding(.horizontal)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                }
                .allowsHitTesting(!isDropdownVisible)
                .blur(radius: isDropdownVisible ? 3 : 0)
                
                if isDropdownVisible {
                    ScrollView {
                        ForEach(filteredSkills, id: \.self) { skill in
                            Button(action: {
                                if self.selectedSkills.contains(skill) {
                                    self.selectedSkills.removeAll(where: { $0 == skill })
                                } else {
                                    self.selectedSkills.append(skill)
                                }
                            }) {
                                HStack {
                                    Text(skill)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if self.selectedSkills.contains(skill) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color("main_color"))
                                    }
                                }
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.isDropdownVisible = false
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 4))
                    .padding(.horizontal, 30)
                }
                
                
            }
            Spacer()
        }
        .onAppear {
            allSkills = viewModel.skillsName.sorted()
            viewModel.fetchAllStrangersOrders()
            viewModel.strangersOrders = viewModel.strangersOrders.sorted(by: { (firstOrder, secondOrder) -> Bool in
                return firstOrder.byUserEmail < secondOrder.byUserEmail
            })
            
            
        }
        .navigationBarTitle("New Order")
        .padding(.top, 70)
    }
}
