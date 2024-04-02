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
        

                // Получение данных из коллекции
                skillsRef.getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Ошибка получения данных: \(error.localizedDescription)")
                        return
                    }

                    // Обработка полученных данных
                    guard let documents = snapshot?.documents else {
                        print("Данные не найдены")
                        return
                    }

                    for document in documents {
                        // Получение всех полей из документа
                        let data = document.data()
                        for (_, value) in data {
                            if let name = value as? String {
                                self.skillsName.append(name)
                            }
                        }
                    }

                    // Вывод имен в консоль
                    print("Имена: \(self.skillsName)")

            
        }}
    
    
    // Создаем массив экспертиз на основе названий навыков
    func createExpertises() -> [Expertise] {
        var expertises = [Expertise]()
        for skill in skillsName {
            expertises.append(Expertise(name: skill, rating: 0, isChecked: false))
        }
        return expertises
    }
}
