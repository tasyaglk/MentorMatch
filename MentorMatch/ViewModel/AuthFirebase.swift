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
    @Published var users = [UserM]()
    @Published var skillsName = [String]()
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
        getSkillsName()
    }
    
    func handleSignOut() {
        isUserLoggedOut.toggle()
        print(isUserLoggedOut)
        try? auth.signOut()
    }
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    func fetchData() {
        if (signedIn) {
            let db = Firestore.firestore()
            
            db.collection("users").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.users = documents.compactMap { document -> UserM? in
                    let data = document.data()
                    
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
                    
                    return UserM(firstName: firstName, lastName: lastName, status: status, description: description, email: email, education: education, workExperience: workExperience, expertise: expertises)
                }
            }
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
        var userData: [String: Any] = [
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
            "expertises": expertisesData
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
    }
    
    
}


// t4@t.ru
/// tttttt
