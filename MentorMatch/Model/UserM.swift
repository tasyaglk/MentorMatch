//
//  UserM.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.03.2024.
//

// , Decodable,

import Foundation

struct UserM: Comparable, Identifiable {
    
    let id = UUID()
    var firstName: String
    var lastName: String
    var status: String
    var description: String
    var email: String
    var education: Education?
    var workExperience: WorkExperience?
    var expertise: [Expertise]?
    var orders: [Order]?
    var photoURL: String?
    
    static func ==(lhs: UserM, rhs: UserM) -> Bool {
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
    
    static func < (lhs: UserM, rhs: UserM) -> Bool {
        lhs.firstName < rhs.firstName
    }
}


extension UserM {
    init() {
//    id = 
        firstName = "Таисия"
        lastName = "Галкина"
        status = "Всем привет!"
        description = "Изучаю ios-разработку"
        email = "tasya@mail.ru"
        education = Education(place: "ВШЭ", degree: "Бакалавриат", startYear: "2021", endYear: "2025")
        workExperience = WorkExperience(companyName: "", position: "", startYear: "", endYear: "")
        expertise = [Expertise(name: "ios-разработка", rating: 5, isChecked: true), Expertise(name: "С++", rating: 4, isChecked: true)]
        orders = [Order(id: "1", isActive: true, selectedSkills: ["ios-developer"], comment: "lalala", byUserEmail: "t5@t.ru")]
    }
}
