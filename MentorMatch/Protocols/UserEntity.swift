//
//  UserEntity.swift
//  MentorMatch
//
//  Created by Тася Галкина on 01.06.2024.
//

import Foundation

protocol UserEntity: Identifiable, Comparable {
    var firstName: String { get set }
    var lastName: String { get set }
    var status: String { get set }
    var description: String { get set }
    var email: String { get set }
    var education: Education? { get set }
    var workExperience: WorkExperience? { get set }
    var expertise: [Expertise]? { get set }
    var orders: [Order]? { get set }
    var photoURL: String? { get set }
}

