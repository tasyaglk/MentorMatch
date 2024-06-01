//
//  Orderable.swift
//  MentorMatch
//
//  Created by Тася Галкина on 01.06.2024.
//

import Foundation
import FirebaseFirestore

protocol Orderable: Identifiable, Codable, Hashable {
    var id: String? { get }
    var isActive: Bool { get set }
    var selectedSkills: [String] { get set }
    var comment: String { get set }
    var byUserEmail: String { get set }
}

