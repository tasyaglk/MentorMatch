//
//  UserM.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

// , Decodable,

import Foundation

struct UserM: Comparable {
  
        var firstName: String
        var lastName: String
        var status: String
        var description: String
        var email: String
        var education: Education?
        var workExperience: WorkExperience?
        var expertise: [Expertise]?
    
    
//    var firstName: String
//    var lastName: String
//    var status: String
//    var description: String
//    var email: String
//    var placeEd: String?
//    var degreeEd: String?
//    var startYearEd: String?
//    var endYearEd: String?
//    var companyName: String?
//    var position: String?
//    var startYearWE: String?
//    var endYearWE: String?
//    var name: String?
//    var rating: Int?
//    var isChecked: Bool?
//    var rate: Double
//    var cntReviews: Int
//    
    static func ==(lhs: UserM, rhs: UserM) -> Bool {
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
    
    static func < (lhs: UserM, rhs: UserM) -> Bool {
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


extension UserM {
    init() {
        firstName = "Таисия"
        lastName = "Галкина"
        status = "Всем привет!"
        description = "Изучаю ios-разработку"
        email = "tasya@mail.ru"
        education = Education(place: "ВШЭ", degree: "Бакалавриат", startYear: "2021", endYear: "2025")
        workExperience = WorkExperience(companyName: "", position: "", startYear: "", endYear: "")
        expertise = [Expertise(name: "ios-разработка", rating: 5, isChecked: true), Expertise(name: "С++", rating: 4, isChecked: true)]
//        rate = 5
//        cntReviews = 100
    }
}
