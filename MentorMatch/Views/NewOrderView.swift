//
//  NewOrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation
import SwiftUI

struct NewOrderView: View {
    @State private var selectedSkills: [String] = []
    @State private var comment: String = ""
    @State private var searchText: String = ""
    @State private var isDropdownVisible = false
    @State private var isPublic = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthFirebase
    
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    @State private var isSkillsEmptyAlertShown = false
    
    @State private var hasEmptyFields: Bool = false
    
    @State var allSkills = [String]()
    
    var filteredSkills: [String] {
        if searchText.isEmpty {
            return allSkills
        } else {
            return allSkills.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        let user = viewModel.getUser() ?? UserM()
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                
                TextField("Необходимые навыки..", text: $searchText)
                    .background(.white)
                    .cornerRadius(4)
                    .onTapGesture {
                        self.isDropdownVisible = true
                    }
            }
            .padding(.horizontal)
            
            ZStack {
//                if isDropdownVisible {
//                    ScrollView {
//    //                List {
//                        ForEach(filteredSkills, id: \.self) { skill in
//                            Button(action: {
//                                if self.selectedSkills.contains(skill) {
//                                    self.selectedSkills.removeAll(where: { $0 == skill })
//                                } else {
//                                    self.selectedSkills.append(skill)
//                                }
//                            }) {
//                                HStack {
//                                    Text(skill)
//                                        .foregroundColor(.primary)
//                                    Spacer()
//                                    if self.selectedSkills.contains(skill) {
//                                        Image(systemName: "checkmark")
//                                            .foregroundColor(Color("main_color"))
//                                    }
//                                }
//                            }
//                            .padding(.horizontal, 15)
//                            .background(Color(.systemBackground))
//                            .cornerRadius(10)
//                            .listRowInsets(EdgeInsets())
//                        }
//    //                    Spacer()
//                    }
//                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 4))
//                    .padding(.horizontal)
//                    .onTapGesture {
//                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        self.isDropdownVisible = false
//                    }
//                    Spacer()
//                }
                
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
                    
                    VStack {
                        FieldView(isError: hasEmptyFields && comment.isEmpty, isError2: hasEmptyFields && comment.isEmpty, maxLength: 600, labelText: "", type: "usual", prevText: "опишите свой запрос", keyboardType: .default, text: $comment)
                    }
                    .padding(.top, 20)
                    Spacer()
                    ButtonView(title: "опубликовать", height: 50, color: "main_color") {
                        
                        let areSkillsNotSelected = selectedSkills.isEmpty
                        
                        if areSkillsNotSelected {
                            isSkillsEmptyAlertShown = true
                            alertMessage = "Необходимо выбрать навыки"
                            return
                        }
                        
                        if selectedSkills.isEmpty || comment.isEmpty  {
                            hasEmptyFields = true
                        } else {
                            isPublic.toggle()
                            let newOrderId = UUID().uuidString
                            viewModel.saveOrder(email: user.email, order: Order(id: newOrderId, isActive: true, selectedSkills: selectedSkills, comment: comment, byUserEmail: user.email))
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(
                        isPresented: $isPublic) {
                            TabBar()
                        }
                    .padding(.bottom, 5)
                    .padding(.horizontal, 80)
                }
                .blur(radius: isDropdownVisible ? 3 : 0)
    //            Spacer()
                if isDropdownVisible {
                    ScrollView {
    //                List {
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
                            .padding(.horizontal, 15)
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .listRowInsets(EdgeInsets())
                        }
    //                    Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 4))
                    .padding(.horizontal)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.isDropdownVisible = false
                    }
//                    Spacer()
                }
                Spacer()
            }
            .background(Color.white)
            
//            if isDropdownVisible {
//                ScrollView {
////                List {
//                    ForEach(filteredSkills, id: \.self) { skill in
//                        Button(action: {
//                            if self.selectedSkills.contains(skill) {
//                                self.selectedSkills.removeAll(where: { $0 == skill })
//                            } else {
//                                self.selectedSkills.append(skill)
//                            }
//                        }) {
//                            HStack {
//                                Text(skill)
//                                    .foregroundColor(.primary)
//                                Spacer()
//                                if self.selectedSkills.contains(skill) {
//                                    Image(systemName: "checkmark")
//                                        .foregroundColor(Color("main_color"))
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 15)
//                        .background(Color(.systemBackground))
//                        .cornerRadius(10)
//                        .listRowInsets(EdgeInsets())
//                    }
////                    Spacer()
//                }
//                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 4))
//                .padding(.horizontal)
//                .onTapGesture {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                    self.isDropdownVisible = false
//                }
//                Spacer()
//            }
////            Spacer()
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(selectedSkills, id: \.self) { skill in
//                        Text(skill)
//                            .padding(8)
//                            .background(Color("main_color"))
//                            .foregroundColor(.black)
//                        
//                            .cornerRadius(8)
//                            .padding(.horizontal, 4)
//                    }
//                }
//            }
//            
//            VStack {
//                FieldView(isError: hasEmptyFields && comment.isEmpty, maxLength: 600, labelText: "", type: "usual", prevText: "опишите свой запрос", keyboardType: .default, text: $comment)
//            }
//            .padding(.top, 20)
            
//            Spacer()
//            ButtonView(title: "опубликовать", height: 50, color: "main_color") {
//                
//                let areSkillsNotSelected = selectedSkills.isEmpty
//                
//                if areSkillsNotSelected {
//                    isSkillsEmptyAlertShown = true
//                    alertMessage = "Необходимо выбрать навыки"
//                    return
//                }
//                
//                if selectedSkills.isEmpty || comment.isEmpty  {
//                    hasEmptyFields = true
//                } else {
//                    isPublic.toggle()
//                    let newOrderId = UUID().uuidString
//                    viewModel.saveOrder(email: user.email, order: Order(id: newOrderId, isActive: true, selectedSkills: selectedSkills, comment: comment, byUserEmail: user.email))
//                }
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationDestination(
//                isPresented: $isPublic) {
//                    TabBar()
//                }
//            .padding(.bottom, 5)
//            .padding(.horizontal, 80)
//            
            
            
        }
        .alert(isPresented: $isSkillsEmptyAlertShown) {
            Alert(title: Text("Предупреждение"),
                  message: Text("Необходимо выбрать навыки"),
                  dismissButton: .default(Text("OK")) {
                print("OK button pressed")
                self.isSkillsEmptyAlertShown = false
            }
            )
            
        }
        .onAppear {
            allSkills = viewModel.skillsName
            print("lalal \(allSkills)")
        }
        .navigationBarTitle("New Order")
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView()
    }
}
