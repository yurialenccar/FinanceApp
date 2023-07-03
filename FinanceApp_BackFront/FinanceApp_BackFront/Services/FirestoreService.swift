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
    let db = Firestore.firestore()
    var user: String = "user_GabrielRomano"
    var documentName: String
    
    init(documentName: String) {
        self.documentName = documentName
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
    
    public func addObjectInArray <T: Encodable> (_ object: T) {
        let docRef = db.collection(self.user).document(documentName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var goalsArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    goalsArray.append(objectData as [String: Any])

                    docRef.setData([self.documentName: goalsArray]) { error in
                        if let error = error {
                            print("Error writing document: \(error.localizedDescription)!")
                        } else {
                            print("Object added to the array in Firestore")
                        }
                    }
                } catch {
                    print("Error encoding object: \(error.localizedDescription)")
                }
            } else {
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    docRef.setData([self.documentName: [objectData as [String: Any]]]) { error in
                        if let error = error {
                            print("Error writing document: \(error.localizedDescription)!")
                        } else {
                            print("Goal array created in Firestore")
                        }
                    }
                } catch {
                    print("Error encoding object: \(error.localizedDescription)")
                }
            }
        }
    }
    
    public func deleteObjectInArray(index: Int) {
        let docRef = db.collection(self.user).document(self.documentName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var goalsArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                
                // Verificar se o índice fornecido está dentro dos limites do array
                guard index >= 0 && index < goalsArray.count else {
                    print("Invalid index provided")
                    return
                }
                
                goalsArray.remove(at: index)
                
                docRef.setData([self.documentName: goalsArray]) { error in
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
    
    public func readDocument(completion: @escaping (Any)) {
        let docRef = db.collection(user).document("goalsList")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(), let goalsData = data["goals"] as? [[String: Any]] {
                    // O documento existe e contém o campo "goals" que é um array de dicionários
                    var goals: [Goal] = []

                    for goalData in goalsData {
                        do {
                            let goal = try Firestore.Decoder().decode(Goal.self, from: goalData)
                            goals.append(goal)
                        } catch {
                            print("Error decoding goal: \(error.localizedDescription)")
                        }
                    }

                    print("Goals: \(goals)")
                } else {
                    print("Document does not contain goals field")
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
