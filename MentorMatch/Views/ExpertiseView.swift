//
//  ExpertiseView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 11.03.2024.
//

import Foundation
import SwiftUI

struct ExpertiseView: View {
    @State private var expertises = [
        Expertise(name: "iOS Development", rating: 0, isChecked: false),
        Expertise(name: "Android Development", rating: 0, isChecked: false),
        Expertise(name: "Web Development", rating: 0, isChecked: false)
    ]
        
    var body: some View {
            NavigationView {
                List {
                    ForEach(expertises.indices, id: \.self) { index in
                        ExpertiseRowView(expertise: self.$expertises[index])
                    }
                    //.listRowSeparator(.hidden)
                }
                .listStyle(GroupedListStyle()) // Устанавливаем стиль списка
                .background(Color.white) // устанавливаем белый фон для всего списка
                .scrollContentBackground(.hidden)
                //.listRowSeparator(.hidden)
                //.listRowBackground(Color.white)
            }
            .onAppear {
                // Изменяем фоновый цвет для UICollectionViewListLayoutSectionBackgroundColorDecorationView
                UITableView.appearance().backgroundColor = UIColor.white
            }
        }
    
//    init() {
//       UITableView.appearance().separatorStyle = .none
//       UITableViewCell.appearance().backgroundColor = .green
//       UITableView.appearance().backgroundColor = .green
//    }
}

struct ExpertiseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertiseView()
    }
}
