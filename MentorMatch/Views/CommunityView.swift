//
//  CommunityView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation
import SwiftUI

struct CommunityView: View {
    @State private var isScreenOneActive: Bool = true
    
    var body: some View {
        ZStack {
            if isScreenOneActive {
                MentorSearchView()
            } else {
                OrderSearchView()
            }
            
            VStack {
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            isScreenOneActive = true
                        }
                    }) {
                        Text("менторы")
                            .foregroundColor(isScreenOneActive ? .black : .gray)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .background(isScreenOneActive ? Color("main_color").opacity(0.7) : Color.clear)
                    .cornerRadius(80)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isScreenOneActive = false
                        }
                    }) {
                        Text("заказы")
                            .foregroundColor(!isScreenOneActive ? .black : .gray)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .background(!isScreenOneActive ? Color("main_color").opacity(0.7) : Color.clear)
                    .cornerRadius(80)
                }
                .padding(.horizontal, 55)
                .cornerRadius(15)
                
                Spacer()
            }
        }
    }
}
