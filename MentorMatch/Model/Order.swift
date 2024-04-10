//
//  Order.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import Foundation
import FirebaseFirestore

struct Order: Identifiable, Codable, Hashable  {
    
    @DocumentID var id: String?
    var isActive: Bool
    var selectedSkills: [String]
    var comment: String
    var byUserEmail: String
  
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
