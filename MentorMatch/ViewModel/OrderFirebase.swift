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
        db.collection("users").document(email).collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let orders = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
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
            
            self.orders += newOrders
        }
    }
    
    func fetchStrangersOrders(email: String) {
        db.collection("users").document(email).collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let orders = querySnapshot?.documents else {
                print("No documents")
                return
            }
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
            
            self.strangersOrders += newOrders
        }
    }
    
    
}
