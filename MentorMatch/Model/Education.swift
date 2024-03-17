//
//  Education.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation

struct Education{
    var place: String
    var degree: String
    var startYear: String
    var endYear: String
    
    init(place: String, degree: String, startYear: String, endYear: String) {
        self.place = place
        self.degree = degree
        self.startYear = startYear
        self.endYear = endYear
    }
}

//extension Education {
//    init(place: String, degree: String, startYear: String, endYear: String) {
//        self.place = place
//        self.degree = degree
//        self.startYear = startYear
//        self.endYear = endYear
//    }
//}

