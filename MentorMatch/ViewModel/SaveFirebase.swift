//
//  SaveFirebase.swift
//  MentorMatch
//
//  Created by Тася Галкина on 02.04.2024.
//

import Foundation
import Firebase


protocol SaveFirebaseProtocol {
    func saveNewMainInfo(firstName: String, lastName: String, email: String, status: String, description: String, completion: @escaping (Result<Bool, FBError>) -> Void)
    func saveEducationInfo(email: String, newEducationData: Education)
    func saveWorkInfo(email: String, newWorkData: WorkExperience)
    func saveExpertiseInfo(email: String, expertises: [Expertise])
    func saveOrder(email: String, order: Order)
}

extension AuthFirebase: SaveFirebaseProtocol {
    
    func saveNewMainInfo(firstName: String, lastName: String, email: String, status: String, description: String, completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(email).getDocument { document, error in
            if let document = document, document.exists {
                var userData = document.data() ?? [:]
                userData["firstName"] = firstName
                userData["lastName"] = lastName
                userData["description"] = description
                userData["status"] = status
                db.collection("users").document(email).setData(userData) { error in
                    if let error = error {
                        print("Ошибка при обновлении данных пользователя: \(error.localizedDescription)")
                    } else {
                        print("Данные пользователя успешно обновлены.")
                    }
                }
            } else {
                print("Документ пользователя не найден.")
            }
        }
    }
    
    
    func saveEducationInfo(email: String, newEducationData: Education) {
        let db = Firestore.firestore()
        
        let newEducationDataDict: [String: Any] = [
            "place": newEducationData.place,
            "degree": newEducationData.degree,
            "startYear": newEducationData.startYear,
            "endYear": newEducationData.endYear
        ]
        
        db.collection("users").document(email).updateData(["education": newEducationDataDict]) { error in
            if let error = error {
                print("Ошибка при обновлении данных об обучении: \(error.localizedDescription)")
            } else {
                print("Данные об обучении пользователя успешно обновлены.")
            }
        }
    }
    
    func saveWorkInfo(email: String, newWorkData: WorkExperience) {
        let db = Firestore.firestore()
        
        let newWorkDataDict: [String: Any] = [
            "companyName": newWorkData.companyName,
            "position": newWorkData.position,
            "startYear": newWorkData.startYear,
            "endYear": newWorkData.endYear
        ]
        db.collection("users").document(email).updateData(["work": newWorkDataDict]) { error in
            if let error = error {
                print("Ошибка при обновлении данных об обучении: \(error.localizedDescription)")
            } else {
                print("Данные об обучении пользователя успешно обновлены.")
            }
        }
    }
    
    func saveExpertiseInfo(email: String, expertises: [Expertise]) {
        let db = Firestore.firestore()
        
        var expertisesData = [[String: Any]]()
        
        for expertise in expertises {
            let expertiseData: [String: Any] = [
                "name": expertise.name,
                "rating": expertise.rating,
                "isChecked": expertise.isChecked
            ]
            expertisesData.append(expertiseData)
        }
        
        db.collection("users").document(email).updateData(["expertises": expertisesData]) { error in
            if let error = error {
                print("Ошибка при обновлении данных об навыках: \(error.localizedDescription)")
            } else {
                print("Данные об навыках пользователя успешно обновлены.")
            }
        }
    }
    
    func saveOrder(email: String, order: Order) {
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("users").document(email).collection("orders").addDocument(data: [
            "isActive": order.isActive,
            "skills": order.selectedSkills,
            "comment": order.comment,
            "customerEmail": order.byUserEmail
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        db.collection("orders").addDocument(data: [
            "isActive": order.isActive,
            "skills": order.selectedSkills,
            "comment": order.comment,
            "customerEmail": order.byUserEmail
        ]) { error in
            if let error = error {
                print("Ошибка при сохранении заказа: \(error.localizedDescription)")
            } else {
                print("Заказ успешно сохранен.")
            }
        }
    }
}
