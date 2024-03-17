//
//  WorkExperience.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation

struct WorkExperience{
    var companyName: String
    var position: String
    var startYear: String
    var endYear: String
    
    init(companyName: String, position: String, startYear: String, endYear: String) {
        self.companyName = companyName
        self.position = position
        self.startYear = startYear
        self.endYear = endYear
    }
}

//extension WorkExperience {
//    init(companyName: String, position: String, startYear: String, endYear: String) {
//        self.companyName = companyName
//        self.position = position
//        self.startYear = startYear
//        self.endYear = endYear
//    }
//}
