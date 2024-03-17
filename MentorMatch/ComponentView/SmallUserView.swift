//
//  SmallUserView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 13.03.2024.
//

import Foundation
import SwiftUI

struct SmallUserView: View {
    
    var user: UserM
    
    // MARK: - Body
    var body: some View {
        HStack {
//            Image("user")
//                .resizable()
//                .frame(width: Constants.imageWidth, height: Constants.imageWidth)
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
//                .padding(.top, 20)
//                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(user.firstName + " " + user.lastName)
                    //.font(.title)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                Text(user.status)
                    //.font(.title)
                    .fontWeight(.thin)
                    .font(.system(size: 12))
            }
        }
        //.padding(.trailing)
    }
}

struct SmallUserView_Previews: PreviewProvider {
    static var previews: some View {
        SmallUserView(user: UserM())
    }
}

