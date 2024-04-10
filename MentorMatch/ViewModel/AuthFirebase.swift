//
//  AuthFirebase.swift
//  MentorMatch
//
//  Created by Тася Галкина on 14.03.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

enum FBError: Error, Identifiable, Equatable {
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

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case unknown
}

class AuthFirebase: ObservableObject {
    @Published var users = [UserM]()
    @Published var skillsName = [String]()
    @Published var orders = [Order]()
    @Published var strangersOrders = [Order]()
    @Published var isUserLoggedOut = false
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var errorMessage: String?
    
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = self.auth.currentUser?.uid == nil
        }
        fetchData()
        getSkillsName()
        fetchAllOrders()
        fetchAllStrangersOrders()
        
    }
    
    func fetchAllOrders() {
        self.orders.removeAll()
        for user in users {
            if user.email.lowercased() == getUser()?.email.lowercased() {
                print("zalupa \(user.email)")
                getOrders(email: user.email)
            }
            
        }
    }
    
    func fetchAllStrangersOrders() {
        self.strangersOrders.removeAll()
        for user in users {
            fetchStrangersOrders(email: user.email)
        }
    }
    
    func handleSignOut() {
        isUserLoggedOut.toggle()
        try? auth.signOut()
    }
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    func fetchData() {
            let db = Firestore.firestore()
            
            db.collection("users").addSnapshotListener { [self] (querySnapshot, error) in
                guard let users = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.users = users.compactMap { queryDocumentSnapshot -> UserM? in
                    let data = queryDocumentSnapshot.data()
                    
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    
                    let educationData = data["education"] as? [String: Any] ?? [:]
                    let workData = data["work"] as? [String: Any] ?? [:]
                    let expertisesData = data["expertises"] as? [[String: Any]]  ?? [[:]]
                    
                    let place = educationData["place"] as? String ?? ""
                    let degree = educationData["degree"] as? String ?? ""
                    let startYear = educationData["startYear"] as? String ?? ""
                    let endYear = educationData["endYear"] as? String ?? ""
                    let education = Education(place: place, degree: degree, startYear: startYear, endYear: endYear)
                    
                    let companyName = workData["companyName"] as? String ?? ""
                    let position = workData["position"] as? String ?? ""
                    let startYearWork = workData["startYear"] as? String ?? ""
                    let endYearWork = workData["endYear"] as? String ?? ""
                    let workExperience = WorkExperience(companyName: companyName, position: position, startYear: startYearWork, endYear: endYearWork)
                    
                    
                    var expertises = [Expertise]()
                    for expertiseData in expertisesData {
                        let name = expertiseData["name"] as? String ?? ""
                        let rating = expertiseData["rating"] as? Int ?? 3
                        let isChecked = expertiseData["isChecked"] as? Bool ?? false
                        let expertise = Expertise(name: name, rating: rating, isChecked: isChecked)
                        expertises.append(expertise)
                    }
                    
                    let photoURL = data["photoURL"] as? String ?? ""
                    return UserM(firstName: firstName, lastName: lastName, status: status, description: description, email: email, education: education, workExperience: workExperience, expertise: expertises, photoURL: photoURL)
                }
            }
        }
    
    
    func getUser() -> UserM? {
        print(auth.currentUser?.email)
        
        for user in users {
            print(user.email)
            if user.email.lowercased() == auth.currentUser?.email {
                return user
            }
        }
        return nil
    }
    
    func getUserByEmail(email: String) -> UserM {
        for user in users {
            if user.email == email {
                return user
            }
        }
        return UserM(firstName: "", lastName: "", status: "", description: "", email: "")
    }
    
    
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
        print(email + " " + password)
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
    
    func insertNewUser(firstName: String, lastName: String, email: String, password: String, education: Education, workExperience: WorkExperience, expertises: [Expertise], completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        var expertisesData = [[String: Any]]()
        
        for expertise in expertises {
            let expertiseData: [String: Any] = [
                "name": expertise.name,
                "rating": expertise.rating,
                "isChecked": expertise.isChecked
            ]
            expertisesData.append(expertiseData)
        }
        
        let db = Firestore.firestore()
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
            ],
            "expertises": expertisesData,
            "photoURL": ""
        ]
        
        db.collection("users").document(email).setData(userData) { error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
        
        UnsplashAPIManager.getRandomPhoto { result in
            switch result {
            case .success(let photoURL):
                db.collection("users").document(email).updateData(["photoURL": photoURL]) { error in
                    if let error = error {
                        print("Ошибка при обновлении данных об обучении: \(error.localizedDescription)")
                    } else {
                        print("Данные об обучении пользователя успешно обновлены.")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(.error(error.localizedDescription)))
                }
            }
        }
    }
    
    func checkUserExists(email: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(false)
            } else {
                if let documents = querySnapshot?.documents, !documents.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
