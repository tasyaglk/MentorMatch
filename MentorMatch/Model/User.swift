//
//  UserMenty.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

// , Decodable,

import Foundation

struct User: Comparable {
    var firstName: String
    var lastName: String
    var status: String
    var description: String
    var email: String
    var education: Education?
    var workExperience: WorkExperience?
    var expertise: [Expertise]?
//    var rate: Double
//    var cntReviews: Int
//    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
    
//    init(firstName: String, lastName: String, status: String, country: String, description: String, email: String, password: String, education: Education, workExperience: WorkExperience, expertise: Expertise, rate: Double, cntReviews: Int) {
//            self.firstName = firstName
//            self.lastName = lastName
//            self.status = status
//            self.description = description
//            self.email = email
//            self.education = education
//            self.workExperience = workExperience
//        self.rate = rate
//        self.cntReviews = cntReviews
//            //self.expertise = expertise[0]
//        }
}


extension User {
    init() {
        firstName = "Таисия"
        lastName = "Галкина"
        status = "лалала"
        description = "лалала2"
        email = "tasya@mail.ru"
        education = Education(place: "ВШЭ", degree: "Бакалавриат", startYear: 2021, endYear: 2025)
        workExperience = WorkExperience(companyName: "Моя", position: "СЕО", startYear: 2003, endYear: 2025)
        expertise = [Expertise(name: "lala", rating: 3, isChecked: true)]
//        rate = 5
//        cntReviews = 100
    }
}
