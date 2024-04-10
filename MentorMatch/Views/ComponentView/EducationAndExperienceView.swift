//
//  EducationAndExoerienceView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 12.03.2024.
//

import Foundation
import SwiftUI

struct EducationAndExperienceView: View {
    
    
    let label1: String
    let label2: String
    let label3: String
    let label4: String
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(label1)
                    .font(.headline)
                Text(label2)
                    .font(.body)
                Text("\(label3) - \(label4)")
            }
        }
    
}


struct EducationAndExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        EducationAndExperienceView(label1: "ВШЭ", label2: "бакалавриат", label3: "2021", label4: "2025")
    }
}
