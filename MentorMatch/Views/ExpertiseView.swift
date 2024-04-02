//
//  ExpertiseView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 11.03.2024.
//

import Foundation
import SwiftUI

struct ExpertiseView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel = AuthFirebase()
    @State var isSaveExpertise:Bool = false
    @State private var expertises = [Expertise]()

    var body: some View {
        let user = viewModel.getUser() ?? UserM()
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
        ButtonView(title: "сохраниить",  color: "main_color") {
            isSaveExpertise.toggle()
            viewModel.saveExpertiseInfo(email: user.email, expertises: expertises)
            presentationMode.wrappedValue.dismiss()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(text: "навыки"))
        .onAppear {
            expertises = user.expertise!
            print(expertises)
        }
    }
        
}

struct ExpertiseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertiseView()
    }
}

