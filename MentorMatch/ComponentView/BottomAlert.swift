////
////  BottomAlert.swift
////  MentorMatch
////
////  Created by Тася Галкина on 07.04.2024.
////
//
//import Foundation
//
//struct BottomAlert: View {
//    let message: String
//    let action: () -> Void
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                Button(action: action) {
//                    Text(message)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 20)
//                .padding(.trailing, 20)
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}
