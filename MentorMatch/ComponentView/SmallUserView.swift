//
//  SmallUserView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 13.03.2024.
//

import Foundation
import SwiftUI

struct SmallUserView: View {
    
    var buttonClicked: (() -> Void)?
    
    var user: UserM
    
    @State var viewUserProfile: Bool = false
    // MARK: - Body
    var body: some View {
        
        Button(action: {
//            UserView(userr: user)
            viewUserProfile.toggle()
        }, label: {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(user.firstName + " " + user.lastName)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                    Text(user.status)
                        //.font(.title)
                        .fontWeight(.thin)
                        .font(.system(size: 12))
                }
            }
            Spacer()
        })
        .navigationBarBackButtonHidden(true)
        //.navigationBarItems(leading: CustomBackButton(text: "3"))
        .navigationDestination(
            isPresented: $viewUserProfile) {
                UserView(userr: user)
    //                            RegistrationExpertiseView(firstName: "", lastName: "", email: "", password: "", educationPlace: "", educationLevel: "", educationStartYear: "", educationEndYear: "", workPlacePlace: "", position: "", workStartYear: "", workEndYear: "")
            }
        .foregroundColor(.black)
    }
    
    
    init(user: UserM, buttonClicked: (() -> Void)? = nil) {
        self.user = user
        self.buttonClicked = buttonClicked
    }
}

struct SmallUserView_Previews: PreviewProvider {
    static var previews: some View {
        SmallUserView(user: UserM())
    }
}

