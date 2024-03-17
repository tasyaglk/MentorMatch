//
//  AuthFirebase.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

enum FBError: Error, Identifiable {
    case error(String)
    
    var id: UUID {
        UUID()
    }
    
    var errorMessage: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

class AuthFirebase: ObservableObject {
    // MARK: - Fields
    @Published var users = [UserM]()
    //@Published var tasks = [Task]()
    //@Published var anotherTasks = [Task]()
    //@Published var subscriptions = [UserM]()
    @Published var isUserLoggedOut = false
    //@Published var subTasks = [Task]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var errorMessage: String?
    
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = self.auth.currentUser?.uid == nil
        }
        fetchData()
    }
    
    func handleSignOut() {
        isUserLoggedOut.toggle()
        try? auth.signOut()
    }
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    // MARK: - Actions
        func fetchData() {
            if (signedIn) {
                db.collection("users").addSnapshotListener { [self] (querySnapshot, error) in
                    guard let users = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
    
    
    
                    self.users = users.map { queryDocumentSnapshot -> UserM in
                        let data = queryDocumentSnapshot.data()
    
                        let firstName = data["firstName"] as? String ?? ""
                        let lastName = data["lastName"] as? String ?? ""
                        let status = data["status"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let email = data["email"] as? String ?? ""
//                        let education = data["education"] as? Education ?? Education(place: "", degree: "", startYear: "", endYear: "")
//                        let workExperience = data["work"] as? WorkExperience ?? WorkExperience(companyName: "", position: "", startYear: "", endYear: "")
                        //let expertise: [Expertise]?
    
//                        let name = data["name"] as? String ?? ""
//                        let username = data["username"] as? String ?? ""
//                        let email = data["email"] as? String ?? ""
//                        let pic = data["pic"] as? String ?? "none"
//                        let subscriptionsEmails = data["subscriptions"] as? [String] ?? [String]()
                        
                        //let education: Education
                        let educationData = data["education"] as! [String: Any]
                        
                        let place = educationData["place"] as? String ?? ""
                        let degree = educationData["degree"] as? String ?? ""
                        let startYearEd = educationData["startYear"] as? String ?? ""
                        let endYearEd = educationData["endYear"] as? String ?? ""
                        // Создаем объект Education
                         let education = Education(place: place, degree: degree, startYear: startYearEd, endYear: endYearEd)
                        
                        //let workExperience: WorkExperience
                            
                            // Данные о работе
                            let workData = data["work"] as! [String: Any]
                        let companyName = workData["companyName"] as? String ?? ""
                        let position = workData["position"] as? String ?? ""
                        let startYear = workData["startYear"] as? String ?? ""
                        let endYear = workData["endYear"] as? String ?? ""
                        // Создаем объект WorkExperience
                        let workExperience = WorkExperience(companyName: companyName, position: position, startYear: startYear, endYear: endYear)
    
                        return UserM(firstName: firstName, lastName: lastName, status: status, description: description, email: email, education: education, workExperience: workExperience)
                    }
                }
//                getTasks()
//                fetchSubscriptions()
//                for elem in subscriptions {
//                    fetchFriendsTasks(email: elem.email)
//                }
            }
        }
    
        func getUser() -> UserM? {
            print(auth.currentUser?.email)
            
            for user in users {
                print(user.email)
                if user.email == auth.currentUser?.email {
                    return user
                }
            }
            return nil
        }
    //
    //    func getUserByEmail(email: String) -> User? {
    //        for user in users {
    //            if user.email == email {
    //                return user
    //            }
    //        }
    //
    //        return nil
    //    }
    
    
    func signIn (email: String, password: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                DispatchQueue.main.async {
                    complition(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async{
                    complition(.success(true))
                }
            }
        }
    }
    
    func signUp (email: String, password: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error {
                DispatchQueue.main.async {
                    complition(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async{
                    complition(.success(true))
                }
            }
        }
    }
    
    func insertNewUser(firstName: String, lastName: String, email: String, password: String, education: Education, workExperience: WorkExperience, expertise: Expertise, complition: @escaping (Result<Bool, FBError>) -> Void) {
        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "education": [
                "place": education.place,
                "degree": education.degree,
                "startYear": education.startYear,
                "endYear": education.endYear
            ],
            "work": [
                "companyName": workExperience.companyName,
                "position": workExperience.position,
                "startYear": workExperience.startYear,
                "endYear": workExperience.endYear
            ]
//            "education": [
//                "place": education.place,
//                "degree": education.degree,
//                "startYear": education.startYear,
//                "endYear": education.endYear
//            ]
        ]
        
        let db = Firestore.firestore()
        db.collection("users").document(email).setData(userData) { error in
            if let error {
                DispatchQueue.main.async {
                    complition(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async{
                    complition(.success(true))
                }
            }
        }
        
        
        
        //        db.collection("users").document(email).setData([
        //            "email": email,
        //            "name": "",
        //            "username": "",
        //            "pic": ""
        //        ]) { err in
        //            if let err = err {
        //                print("Error writing document: \(err)")
        //            } else {
        //                print("Document successfully written!")
        //            }
        //        }
    }
    //
    //    func removeUser(email: String) {
    //        db.collection("users").document(email).delete() { err in
    //            if let err = err {
    //                print("Error removing document: \(err)")
    //            } else {
    //                print("Document successfully removed!")
    //            }
    //        }
    //    }
    //
    //    func insertUserInfo(email: String, username: String, name: String, pic: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
    //        fetchData()
    //        var flag = false
    //        for usr in users {
    //            if usr.username == username {
    //                flag = true
    //            }
    //        }
    //
    //        if flag {
    //            complition(.failure(.error("User with such username already exists")))
    //        } else {
    //            let docRef = db.collection("users").document(auth.currentUser?.email ?? "")
    //            docRef.updateData([
    //                "username": username,
    //                "name": name,
    //                "pic": pic
    //            ])
    //            complition(.success(true))
    //        }
    //    }
}
