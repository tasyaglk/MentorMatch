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
    
    var userr: UserM
    
    @StateObject var imageLoader = ImageLoader()
    
    @State var viewUserProfile: Bool = false
    // MARK: - Body
    var body: some View {
        
        Button(action: {
//            UserView(userr: user)
            viewUserProfile.toggle()
        }, label: {
            HStack {
                VStack {
                    if userr.photoURL == "" {
                        Image("Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle()) // Делает изображение круглым
                            .frame(width: 50, height: 50) // Устанавливает средний размер
                    } else {
                        if let image = imageLoader.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle()) // Делает изображение круглым
                                .frame(width: 50, height: 50) // Устанавливает средний размер
                        } else {
                            Text("Загрузка...")
                                .padding()
                        }
                    }
                }
                .onAppear {
                    if let url = URL(string: userr.photoURL ?? "") {
                        imageLoader.load(url: url)
                    }
                }
                VStack(alignment: .leading) {
                    Text(userr.firstName + " " + userr.lastName)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                    Text(userr.status)
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
                UserView(userr: userr)
    //                            RegistrationExpertiseView(firstName: "", lastName: "", email: "", password: "", educationPlace: "", educationLevel: "", educationStartYear: "", educationEndYear: "", workPlacePlace: "", position: "", workStartYear: "", workEndYear: "")
            }
        .foregroundColor(.black)
    }
    
    
    init(user: UserM, buttonClicked: (() -> Void)? = nil) {
        self.userr = user
        self.buttonClicked = buttonClicked
    }
}

struct SmallUserView_Previews: PreviewProvider {
    static var previews: some View {
        SmallUserView(user: UserM())
    }
}

