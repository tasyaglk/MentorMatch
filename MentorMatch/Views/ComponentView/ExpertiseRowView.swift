////
////  ExpertiseRowView.swift
////  MentorMatch
////
////  Created by Тася Галкина on 11.03.2024.
////
//
//
import Foundation
import SwiftUI

struct ExpertiseRowView: View {
    @Binding var expertise: Expertise
    
    var body: some View {
        HStack {
            Button(action: {
                self.expertise.isChecked.toggle()
            }) {
                Image(systemName: expertise.isChecked ? "checkmark.square" : "square")
                    .foregroundColor(Color("main_color"))
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Text(expertise.name)
            
            Spacer()
            
            if expertise.isChecked {
                ForEach(1..<6) { index in
                    Image(systemName: index <= expertise.rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            expertise.rating = index
                        }
                }
            }
        }
        .padding(.leading, 0)
    }
}

//#Preview {
//    ExpertiseRowView(expertise: [Expertise(name: "w", rating: 3, isChecked: false)])
//}
