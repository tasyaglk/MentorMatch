//
//  RegistrationViewExpertise.swift
//  MentorMatch
//
//  Created by Тася Галкина on 20.03.2024.
//


import Foundation
import SwiftUI

struct RegistrationExpertiseView: View {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let educationPlace: String
    let educationLevel: String
    let educationStartYear: String
    let educationEndYear: String
    let workPlace: String
    let position: String
    let workStartYear: String
    let workEndYear: String
    
    
    @State var isNext: Bool = false
    @EnvironmentObject var authFirebase: AuthFirebase
    @State private var isAlertShow: Bool = false
    @State private var alertMessage: String = ""
    @State var expertises: [Expertise] = []
    
    private let user = UserM()
    
    var body: some View {
//        HStack {
//            Text(firstName + lastName + email + password)
//        }
        
        VStack {
            VStack {
                ForEach(expertises.indices, id: \.self) { index in
                    ExpertiseRowView(expertise: $expertises[index])
                }
            }
            .listStyle(GroupedListStyle())
            .background(Color.white)
            .scrollContentBackground(.hidden)
        }
        
        Spacer()
        ButtonView(title: "далее",  color: "main_color") {
            isNext.toggle()
            authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: workPlace, position: position, startYear: workStartYear, endYear: workEndYear), expertises: expertises) { result in
                switch result {
                case (.success(_)) :
                    isNext = true
                case(.failure(let error)):
                    //authFirebase.errorMessage = error.errorMessage
                    alertMessage = error.errorMessage
                    isAlertShow = true
                }
            }
        }
        //            }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            trailing:  Button(action: {
                isNext.toggle()
                expertises = []
                authFirebase.insertNewUser(firstName: firstName, lastName: lastName, email: email, password: password, education: Education(place: educationPlace, degree: educationLevel, startYear: educationStartYear, endYear: educationEndYear), workExperience: WorkExperience(companyName: workPlace, position: position, startYear: workStartYear, endYear: workEndYear), expertises: expertises) { result in
                    switch result {
                    case (.success(_)) :
                        isNext = true
                    case(.failure(let error)):
                        //authFirebase.errorMessage = error.errorMessage
                        alertMessage = error.errorMessage
                        isAlertShow = true
                    }
                }
            }) {
                Text("пропустить")
                    .foregroundColor(Color("main_color"))
            }
        )
        .navigationDestination(
            isPresented: $isNext) {
                TabBar()
            }
            .padding(.horizontal, 100)
            .padding(.bottom, 15)
            .padding(.top, 5)
            .alert(isPresented: $isAlertShow) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                self.expertises = authFirebase.createExpertises()
            }
    }
}



#Preview {
    RegistrationEdView(firstName: "", lastName: "", email: "", password: "")
}
