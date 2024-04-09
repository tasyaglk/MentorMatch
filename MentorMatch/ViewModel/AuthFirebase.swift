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
        //        getOrders()
//        for i in orders {
////            print(i)
//        }
        fetchAllOrders()
        fetchAllStrangersOrders()
        
    }
    
    //    func fetchAllsOrders() {
    //        orders = [Order]()
    //        getOrders(email: auth.currentUser?.email ?? "")
    //    }
    
    func fetchAllOrders() {
        self.orders.removeAll()
        for user in users {
//            print("zalupa \(user.email)")
            if user.email.lowercased() == getUser()?.email.lowercased() {
                print("zalupa \(user.email)")
                getOrders(email: user.email)
            }
            
        }
    }
    
    
    func fetchAllStrangersOrders() {
        self.strangersOrders.removeAll()
        for user in users {
//            print("zalupa \(user.email)")
            fetchStrangersOrders(email: user.email)
        }
    }
    
    func handleSignOut() {
        isUserLoggedOut.toggle()
//        print(isUserLoggedOut)
        try? auth.signOut()
    }
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    func fetchData() {
//        if (signedIn) {
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
//                    print(email)
                    
                    let educationData = data["education"] as? [String: Any] ?? [:]
                    let workData = data["work"] as? [String: Any] ?? [:]
                    let expertisesData = data["expertises"] as? [[String: Any]]  ?? [[:]]
                    let ordersData = data["orders"] as? [[String: Any]]  ?? [[:]]
                    
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
                //                fetchAllStrangersOrders()
            }
        }
        
        //        getSkillsName()
        ////        getOrders()
        //        for i in users {
        //            print("123 \(i)")
        //        }
        //
        //        for user in users {
        //            fetchStrangersOrders(email: user.email)
        //            print(user.email)
        //        }
//    }
    
    
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
//            print(user.email)
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
    
//    func checkExistingUserAndSignUp(email: String) -> Bool {
//        let db = Firestore.firestore()
//        var ans: Bool = false
//        
//        // Запрашиваем документ с данными пользователя по его email
//        db.collection("users").document(email).getDocument(completion: <#T##(DocumentSnapshot?, Error?) -> Void#>){ (querySnapshot, error) in
//            if let error = error {
//                // Обработка ошибки запроса
//                print("Ошибка при запросе пользователя: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let documents = querySnapshot?.documents else {
//                // Документы не найдены
//                print("Документы не найдены")
//                return
//            }
//            
//            if documents.isEmpty {
//                // Пользователь с такой почтой не найден, регистрируемся
//                ans = false
//                print("hjhfbvovboevbqoieboervboierbqoiebqirbvpqirbvqpibvqperibvpqebpqeirbpqerpqeribuvpqeir")
//            } else {
//                // Пользователь с такой почтой уже существует, выводим алерт
//                ans = true
//            }
//        }
//        return ans
//    }
    
    func checkUserExists(email: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(false)
            } else {
                if let documents = querySnapshot?.documents, !documents.isEmpty {
                    // Пользователь с такой почтой найден
                    completion(true)
                } else {
                    // Пользователь с такой почтой не найден
                    completion(false)
                }
            }
//            print("hghkgchcciuctutc")
        }
    }

    func savePhotoToFirebase(imageData: Data) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let photoRef = storageRef.child("photos").child("\(UUID().uuidString).jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let _ = photoRef.putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                print("Ошибка при загрузке изображения: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }

            photoRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Ошибка при получении ссылки на загруженное изображение: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                    return
                }
                
                // Обновляем профиль пользователя в базе данных
                self.updateUserProfile(photoURL: downloadURL.absoluteString)
            }
        }
    }

    func updateUserProfile(photoURL: String) {
        // Получаем ссылку на базу данных Firebase
        let db = Firestore.firestore()
        
        // Получаем текущего пользователя (предполагается, что у вас есть механизм аутентификации пользователя)
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Пользователь не аутентифицирован")
            return
        }
        
        // Обновляем данные о фотографии пользователя в базе данных
        let userRef = db.collection("users").document(currentUserID)
        userRef.updateData([
            "photoURL": photoURL
        ]) { error in
            if let error = error {
                print("Ошибка при обновлении профиля пользователя: \(error.localizedDescription)")
            } else {
                print("Профиль пользователя успешно обновлен")
            }
        }
    }

    
    
}


// t4@t.ru
/// tttttt
