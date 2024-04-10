//
//  SkillsFirebase.swift
//  MentorMatch
//
//  Created by Тася Галкина on 02.04.2024.
//

import Foundation
import FirebaseFirestore


extension AuthFirebase {

    func getSkillsName() {
        let db = Firestore.firestore()
        let skillsRef = db.collection("skills")
        
        skillsRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка получения данных: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Данные не найдены")
                return
            }
            
            for document in documents {
                let data = document.data()
                for (_, value) in data {
                    if let name = value as? String {
                        self.skillsName.append(name)
                    }
                }
            }
        }
    }
    
    func createExpertises() -> [Expertise] {
        var expertises = [Expertise]()
        for skill in skillsName {
            expertises.append(Expertise(name: skill, rating: 0, isChecked: false))
        }
        return expertises
    }
    
    func isMentorHasSkills(selectedSkills: [String], user: UserM) -> Bool{
        let selectedSkillsSet = Set(selectedSkills)
        let userSkillNames = user.expertise?.compactMap { $0.isChecked ? $0.name : nil } ?? []
        let userSkillNamesSet = Set(userSkillNames)
        return selectedSkillsSet.isSubset(of: userSkillNamesSet)
    }
    
    func isOrderHasSkills(selectedSkills: [String], order: Order) -> Bool{
        let selectedSkillsSet = Set(selectedSkills)
        let orderSkillNames = order.selectedSkills.compactMap { $0 } ?? []
        let orderSkillNamesSet = Set(orderSkillNames)
        return selectedSkillsSet.isSubset(of: orderSkillNamesSet)
    }
}
