//
//  Validator.swift
//  MentorMatch
//
//  Created by Тася Галкина on 07.04.2024.
//

import Foundation

enum Validator {
    static func isEmailCorrect(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isPasswordCorrect(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    static func isOnlyDigits(_ string: String) -> Bool {
        let digitRegex = "^[0-9]*$"
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        return digitPredicate.evaluate(with: string)
    }
    
    static func isNotEmpty(_ string: String) -> Bool {
        return !string.isEmpty
    }
//    static func isNotEmpty(_ string: String) -> Bool {
//        return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//    }
}
