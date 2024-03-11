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
            // Содержимое экрана
            if isScreenOneActive {
                MentorSearchView()
            } else {
                OrderSearchView()
            }

            // Переключатель экранов, расположенный поверх содержимого
            VStack {
                // Переключатель экранов
                HStack(spacing: 0) {
                    // Кнопка для первого экрана
                    Button(action: {
                        withAnimation {
                            isScreenOneActive = true
                        }
                    }) {
                        Text("менторы")
                            .foregroundColor(isScreenOneActive ? .black : .gray)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            //.foregroundColor(.black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .background(isScreenOneActive ? Color("main_color").opacity(0.7) : Color.clear)
                    .cornerRadius(80)

                    // Кнопка для второго экрана
                    Button(action: {
                        withAnimation {
                            isScreenOneActive = false
                        }
                    }) {
                        Text("заказы")
                            .foregroundColor(!isScreenOneActive ? .black : .gray)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                            //.foregroundColor(.black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .background(!isScreenOneActive ? Color("main_color").opacity(0.7) : Color.clear)
                    .cornerRadius(80)
                }
                //.frame(height: 50) // Задаём высоту для области кнопок
                .padding(.horizontal, 55)
                //.background(Color("main_color").opacity(0.5)) // Фон для объединения кнопок в один элемент
                .cornerRadius(15)
                ///.padding(.top, 65)

                Spacer() // Этот Spacer перемещает переключатель вверх экрана
            }
        }
        //.edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CommunityView()
}
