//
//  Expertise.swift
//  MentorMatch
//
//  Created by Тася Галкина on 11.03.2024.
//

import Foundation

struct Expertise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var rating: Int
    var isChecked: Bool
}
