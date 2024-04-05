//
//  Order.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import Foundation
import FirebaseFirestore
//import FirebaseFirestoreSwift

struct Order: Identifiable, Codable, Hashable  {
    
    @DocumentID var id: String?
    var isActive: Bool
    var selectedSkills: [String]
    var comment: String
    var byUserEmail: String
    
//
//    
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }
//    static func > (lhs: Order, rhs: Order) -> Bool {
//        lhs.isActive > rhs.isActive
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
//    init(id: String, isActive: Bool, selectedSkills: [String], comment: String, byUserEmail: String) {
   //        self.id = id
   //        self.isActive = isActive
   //        self.selectedSkills = selectedSkills
   //        self.comment = comment
   //        self.byUserEmail = byUserEmail
   //    }
}
