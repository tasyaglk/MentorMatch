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
    
    let allSkills = [
        "iOS Development",
        "Android Development",
        "Web Development",
        "UI/UX Design",
        "Database Management",
        "Project Management",
        "Graphic Design",
        "iOS Development",
        "Android Development",
        "Web Development",
        "UI/UX Design",
        "Database Management",
        "Project Management",
        "Graphic Design",
        "iOS Development",
        "Android Development",
        "Web Development",
        "UI/UX Design",
        "тыква",
        "тамя",
        "тася",
    ]
    
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
                TextField("Необходимые навыки..", text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        self.isDropdownVisible = true
                    }
            }
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
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                .onTapGesture {
                    // Скрытие списка при нажатии вне него
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.isDropdownVisible = false
                }
            }
            
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
                FieldView(maxLength: 600, labelText: "", prevText: "опишите свой запрос", type: "usual")
            }
            .padding(.top, 20)
            
            Spacer()
            ButtonView(title: "опубликовать", height: 50, color: "main_color") {
                isPublic.toggle()
                //presentationMode.wrappedValue.dismiss()
                //// костыль
                
            }
            .navigationBarBackButtonHidden(true)
            //.navigationBarItems(leading: CustomBackButton(text: ""))
            .navigationDestination(
                isPresented: $isPublic) {
                    CommunityView()
                }
            .padding(.bottom, 5)
            .padding(.horizontal, 80)
            
            
            
        }
        .navigationBarTitle("New Order")
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView()
    }
}
