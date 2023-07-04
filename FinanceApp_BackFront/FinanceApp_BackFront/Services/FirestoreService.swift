//
//  Firestore.swift
//  FinanceApp_BackFront
//
//  Created by Gabriel Luz Romano on 29/06/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    private let db = Firestore.firestore()
    private var user: String = "user_GabrielRomano"
    private var documentName: String
    private let docRef: DocumentReference
    
    init(documentName: String) {
        self.documentName = documentName
        self.docRef = db.collection(user).document(documentName)
    }
    
    
    //    public func addGoalInArray(document: String, goal: Goal) {
    //        let docRef = db.collection(self.user).document(document)
    //
    //        docRef.getDocument { (document, error) in
    //            if let document = document, document.exists {
    //                var goalsArray = document.data()?["goals"] as? [[String: Any]] ?? []
    //                let goalData = try? Firestore.Encoder().encode(goal)
    //
    //                goalsArray.append(goalData ?? [:])
    //
    //                docRef.setData(["goals": goalsArray]) { error in
    //                    if let error = error {
    //                        print("Error writing document: \(error.localizedDescription)!")
    //                    } else {
    //                        print("Goal added to the array in Firestore")
    //                    }
    //                }
    //            } else {
    //                let goalData = try? Firestore.Encoder().encode(goal)
    //                docRef.setData(["goals": [goalData ?? [:]]]) { error in
    //                    if let error = error {
    //                        print("Error writing document: \(error.localizedDescription)!")
    //                    } else {
    //                        print("Goal array created in Firestore")
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    //    public func addObjectInArray(document: String, object: Any) {
    //        let docRef = db.collection(self.user).document(document)
    //        let goal: Goal = Goal(desc: "", imageName: "", savedAmount: 0, goalValue: 0, targetDate: "")
    //        docRef.getDocument { (document, error) in
    //            if let document = document, document.exists {
    //                var goalsArray = document.data()?["goals"] as? [[String: Any]] ?? []
    //                let goalData = try? Firestore.Encoder().encode(object)
    //
    //                goalsArray.append(goalData ?? [:])
    //
    //                docRef.setData(["goals": goalsArray]) { error in
    //                    if let error = error {
    //                        print("Error writing document: \(error.localizedDescription)!")
    //                    } else {
    //                        print("Goal added to the array in Firestore")
    //                    }
    //                }
    //            } else {
    //                let goalData = try? Firestore.Encoder().encode(object)
    //                docRef.setData(["goals": [goalData ?? [:]]]) { error in
    //                    if let error = error {
    //                        print("Error writing document: \(error.localizedDescription)!")
    //                    } else {
    //                        print("Goal array created in Firestore")
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    public func addObjectInArray <T: Encodable> (_ object: T, completion: @escaping (String) -> Void) {
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var goalsArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    goalsArray.append(objectData as [String: Any])
                    
                    self.docRef.setData([self.documentName: goalsArray]) { error in
                        if let error = error {
                            completion("Error writing document: \(error.localizedDescription)!")
                        } else {
                            completion("Success")
                        }
                    }
                } catch {
                    completion("Error encoding object: \(error.localizedDescription)")
                }
            } else {
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    self.docRef.setData([self.documentName: [objectData as [String: Any]]]) { error in
                        if let error = error {
                            completion("Error writing document: \(error.localizedDescription)!")
                        } else {
                            completion("Goal array created in Firestore")
                        }
                    }
                } catch {
                    completion("Error encoding object: \(error.localizedDescription)")
                }
            }
        }
    }
    
    public func deleteObjectInArray(index: Int) {
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var goalsArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                
                // Verificar se o índice fornecido está dentro dos limites do array
                guard index >= 0 && index < goalsArray.count else {
                    print("Invalid index provided")
                    return
                }
                
                goalsArray.remove(at: index)
                
                self.docRef.setData([self.documentName: goalsArray]) { error in
                    if let error = error {
                        print("Error writing document: \(error.localizedDescription)!")
                    } else {
                        print("Object removed from the array in Firestore")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    public func readDocument() -> [[String: Any]] { //completion: @escaping (Any)
        var dataReturn:[[String: Any]] = []
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(), let goalsData = data[self.documentName] as? [[String: Any]] {
                    dataReturn = goalsData
                } else {
                    print("Document does not contain goals field")
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "")")
            }
        }
        return dataReturn
    }
    
    func getObjectData<T: Codable>(forObjectType objectType: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
//        guard let currentUserID = Auth.auth().currentUser?.uid else {
//            completion(.failure(NSError(domain: "FirestoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuário não autenticado"])))
//            return
//        }
        
        docRef.getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Documento não existe ou houve um erro"])))
                return
            }
            
            if let data = document.data(), let goalsData = data[self.documentName] as? [[String: Any]] {
                
                var goals: [T] = []
                
                for goalData in goalsData {
                    do {
                        let goal = try Firestore.Decoder().decode(T.self, from: goalData)
                        goals.append(goal)
                    } catch {
                        print("Error decoding goal: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                completion(.success(goals))
            } else {
                print("Document does not contain goals field")
                completion(.success([]))
            }
        }
    }
}
