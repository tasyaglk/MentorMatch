//
//  StrangerOrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 05.04.2024.
//

import Foundation
import SwiftUI

struct StrangerOrderView: View {
    
    var order: Order
    var user: UserM
    
    @State var viewOrderDescription: Bool = false

    @ObservedObject private var viewModel = AuthFirebase()
    
    var body: some View {
        
        Button(action: {
            viewOrderDescription.toggle()
        }, label: {
            VStack(alignment: .leading) {
                    HStack {
                        ForEach(order.selectedSkills, id: \.self) { skill in
                            Text(skill)
                                .padding(8)
                                .background(Color("main_color"))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .padding(.horizontal, 4)
                        }
                    }
                HStack {
                    Text("\(user.firstName) \(user.lastName)")
                }
                
            }
            
            
            
        })
        .navigationBarBackButtonHidden(true)
        //.navigationBarItems(leading: CustomBackButton(text: "3"))
        .navigationDestination(
            isPresented: $viewOrderDescription) {
//                UserView(userr: user)
                FullOrderDescription(order: order, user: user)
            }
        .foregroundColor(.black)
    }
    
//    var body: some View  {
//        VStack {
//            HStack {
//                //            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(order.selectedSkills, id: \.self) { skill in
//                        Text(skill)
//                            .padding(8)
//                            .background(Color("main_color"))
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//                            .padding(.horizontal, 4)
//                    }
//                }
//            }
//        }
//        HStack {
//            Text("\(user.firstName) \(user.lastName)")
//        }
//    }
}
