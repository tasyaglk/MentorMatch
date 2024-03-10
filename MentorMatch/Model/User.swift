//
//  UserMenty.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var status: String
    var city: String
    var description: String
    var email: String
    var education: Education
    var workExperience: WorkExperience
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
    
    //    init(firstName: String, lastName: String, status: String, country: String, description: String, email: String, password: String, education: Education, workExperience: WorkExperience) {
    //        self.firstName = firstName
    //        self.lastName = lastName
    //        self.status = status
    //        self.country = country
    //        self.description = description
    //        self.email = email
    //        self.password = password
    //        self.education = education
    //        self.workExperience = workExperience
    //    }
}


extension User {
    init() {
        firstName = "Таисия"
        lastName = "Галкина"
        status = "лалала"
        city = "Москва"
        description = "лалала2"
        email = "tasya@mail.ru"
        education = Education(place: "ВШЭ", degree: "Бакалавриат", startYear: 2021, endYear: 2025)
        workExperience = WorkExperience(companyName: "Моя", position: "СЕО", startYear: 2003, endYear: 2025)
    }
}
