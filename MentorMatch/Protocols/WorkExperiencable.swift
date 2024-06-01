//
//  WorkExperiencable.swift
//  MentorMatch
//
//  Created by Тася Галкина on 01.06.2024.
//

import Foundation

protocol WorkExperiencable {
    var companyName: String { get set }
    var position: String { get set }
    var startYear: String { get set }
    var endYear: String { get set }
}
