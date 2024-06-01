//
//  Expertiseable.swift
//  MentorMatch
//
//  Created by Тася Галкина on 01.06.2024.
//

import Foundation

protocol Expertiseable: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var rating: Int { get set }
    var isChecked: Bool { get set }
}
