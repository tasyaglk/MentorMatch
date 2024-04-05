//
//  WhichOrderView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import Foundation
import SwiftUI

struct WhichOrderView: View {
    var order: Order
    
    // Определяем структуру для управления размерами элементов сетки
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        // Добавьте больше GridItem для управления количеством элементов в строке в зависимости от доступного пространства
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Требуемые навыки:")
                    .font(.headline)
                LazyVGrid(columns: columns) {
                    ForEach(order.selectedSkills, id: \.self) { skill in
                        Text(skill)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color("light_main_color"))
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .cornerRadius(30)
                    }
                }
                // .padding(.horizontal)
                // .padding(.top, 10)
                
                //Spacer().frame(height: 20)
                
//                Text(order.byUser.firstName + " " + order.byUser.lastName)
//                //.font(.title)
//                    .fontWeight(.thin)
//                    .font(.system(size: 12))
//                    .padding(.trailing)
            }
            .padding()
        }
    }
}
//            Text(order.byUser.firstName + " " + order.byUser.lastName)
//                //.font(.title)
//                .fontWeight(.thin)
//                .font(.system(size: 12))
//        }
//        .padding()
//        .navigationBarTitle("Детали заказа", displayMode: .inline)
//    }
//}

//struct WhichOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhichOrderView(order: Order(id: <#String#>, isActive: true,selectedSkills: ["iOS Development", "UI/UX Design1", "UI/UX Design2", "UI/UX Design3", "UI/UX Design4"], comment: "Нужен опытный разработчик", byUserEmail: "lala@lala.ru"))
//    }
//}

