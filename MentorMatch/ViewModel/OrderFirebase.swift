//
//  OrderFirebase.swift
//  MentorMatch
//
//  Created by Тася Галкина on 04.04.2024.
//

import Foundation
import Firebase


extension AuthFirebase {
    func updateOrderStatusInUserDocument(email: String, orderID: String, isDone: Bool) {
        let docRef = db.collection("users").document(email).collection("orders").document(orderID)
        docRef.updateData([
            "isActive": isDone
        ]) { error in
            if let error = error {
                //                           print(orderRef.documentID)
                print("Ошибка при обновлении статуса заказа: \(error.localizedDescription)")
            } else {
                print("Статус заказа успешно обновлен.")
            }
        }
    }
    
    func deleteOrder(orderID: String) {
        db.collection("users").document(auth.currentUser?.email ?? "").collection("orders").document(orderID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func getOrders(email: String) {
//        for user in users {
//            print("!!! \(email)")
            db.collection("users").document(email).collection("orders").addSnapshotListener { (querySnapshot, error) in
                guard let orders = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
//                print("?? \(email)")
//                }
                
                self.orders.removeAll()
                
                var newOrders = [Order]()
                    
                    for document in orders {
                        let data = document.data()
                        let id = document.documentID
                        let comment = data["comment"] as? String ?? ""
                        let isActive = data["isActive"] as? Bool ?? true
                        let skills = data["skills"] as? [String] ?? [""]
                        let byUser = data["customerEmail"] as? String ?? ""
                        let newOrder = Order(id: id, isActive: isActive, selectedSkills: skills, comment: comment, byUserEmail: byUser)
                        print(newOrder)
                        newOrders.append(newOrder)
                        
                    }
                    
                    // Добавляем новые заказы в массив strangersOrders
                    self.orders += newOrders
            }
        }
    
    func fetchStrangersOrders(email: String) {
//        for user in users {
//            print("!!! \(email)")
            db.collection("users").document(email).collection("orders").addSnapshotListener { (querySnapshot, error) in
                guard let orders = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
//                print("!!! \(email)")
//                }
                
//                self.strangersOrders.removeAll()
                
                var newOrders = [Order]()
                    
                    for document in orders {
                        let data = document.data()
                        let id = document.documentID
                        let comment = data["comment"] as? String ?? ""
                        let isActive = data["isActive"] as? Bool ?? true
                        let skills = data["skills"] as? [String] ?? [""]
                        let byUser = data["customerEmail"] as? String ?? ""
                        let newOrder = Order(id: id, isActive: isActive, selectedSkills: skills, comment: comment, byUserEmail: byUser)
                        newOrders.append(newOrder)
                    }
                    
                    // Добавляем новые заказы в массив strangersOrders
                    self.strangersOrders += newOrders
            }
        }
    
    func hui(selectedSkills: [String], user: UserM) -> Bool{
        let selectedSkillsSet = Set(selectedSkills)
            let userSkillNames = user.expertise?.compactMap { $0.isChecked ? $0.name : nil } ?? []
            let userSkillNamesSet = Set(userSkillNames)
            return selectedSkillsSet.isSubset(of: userSkillNamesSet)
    }
    
    func zalupa(selectedSkills: [String], order: Order) -> Bool{
//        let selectedSkillsSet = Set(selectedSkills)
//        let orderSkillNames = order.selectedSkills.flatMap { $0 }
//        let orderSkillNamesSet = Set(orderSkillNames)
//        return selectedSkillsSet.isSubset(of: orderSkillNamesSet)
        let selectedSkillsSet = Set(selectedSkills)
        let orderSkillNames = order.selectedSkills.compactMap { $0 } ?? []
            let orderSkillNamesSet = Set(orderSkillNames)
            return selectedSkillsSet.isSubset(of: orderSkillNamesSet)
    }
        
        
}

//        let db = Firestore.firestore()
//
//        // Получаем текущий список заказов пользователя
//        db.collection("users").document(email).getDocument { document, error in
//            if let document = document, document.exists {
//                var userData = document.data() ?? [:]
//                var orders = userData["orders"] as? [[String: Any]] ?? []
//
//                // Обновляем статус заказа в списке заказов пользователя
//                if let index = orders.firstIndex(where: { $0["id"] as? String == orderID }) {
//                    orders[index]["isActive"] = isActive
//
//                    // Обновляем список заказов в документе пользователя
//                    userData["orders"] = orders
//                    db.collection("users").document(email).setData(userData) { error in
//                        if let error = error {
//                            print("Ошибка при обновлении статуса заказа: \(error.localizedDescription)")
//                        } else {
//                            print("Статус заказа успешно обновлен.")
//                        }
//                    }
//                } else {
//                    print("Заказ с указанным идентификатором не найден.")
//                }
//            } else {
//                print("Документ пользователя не найден.")
//            }
//        }

//        let db = Firestore.firestore()
//        let userDocumentRef = db.collection("users").document(userEmail) // userEmail - это адрес электронной почты пользователя
//
//        userDocumentRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                // Получаем данные о пользователе
//                var userData = document.data()
//
//                // Получаем подколлекцию заказов пользователя
//                if var ordersCollection = userData?["orders"] as? [[String: Any]] {
//                    // Ищем заказ с нужным orderId
//                    if let orderIndex = ordersCollection.firstIndex(where: { $0["id"] as? String == orderId }) {
//                        // Обновляем поле isActive для найденного заказа
//                        ordersCollection[orderIndex]["isActive"] = isActive // newValue - новое значение для поля isActive
//
//                        // Сохраняем изменения обратно в Firestore
//                        userDocumentRef.setData(["orders": ordersCollection], merge: true) { error in
//                            if let error = error {
//                                print("Ошибка при обновлении поля isActive: \(error.localizedDescription)")
//                            } else {
//                                print("Поле isActive успешно обновлено для заказа с orderId: \(orderId)")
//                            }
//                        }
//                    } else {
//                        print("Заказ с orderId: \(orderId) не найден")
//                    }
//                } else {
//                    print("Подколлекция заказов не найдена")
//                }
//            } else {
//                print("Документ пользователя не найден: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
//
//    }

//}
