//
//  TabBar.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation
import SwiftUI

struct TabBar: View {
    @EnvironmentObject var authFirebase: AuthFirebase
    
    var body: some View {
        TabView {
            CommunityView()
                .tabItem {
                    Image(systemName: "person.3")
                }
                .tag(0)
            
            MessageView()
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                }
                .tag(1)
            
            NewOrderView()
                .tabItem {
                    Image(systemName: "plus.circle")
                }
                .tag(2)
            
            
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(3)
            
            
        }
        .onAppear() {
            let appearance = UITabBarAppearance()
            //appearance.backgroundColor = UIColor(.black)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .accentColor(Color("main_color"))
        .environmentObject(AuthFirebase())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBar()
}
