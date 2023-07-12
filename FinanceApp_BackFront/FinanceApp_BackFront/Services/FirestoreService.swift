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
    public var user: String
    private var documentName: String
    
    private var docRef: DocumentReference {
        return db.collection(user).document(documentName)
    }
    
    init(documentName: String = "default") {
        self.user = "user_" + (userLogged ?? "default")
        self.documentName = documentName
    }
    
    public func setUser(_ userUid: String) {
        user = "user_" + (userLogged ?? "default")
    }
    
    public func setDocumentName(_ name: String) {
        self.documentName = name
    }
    
    public func addObjectInArray <T: Encodable> (_ object: T, completion: @escaping (String) -> Void) {
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                var dataArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    dataArray.append(objectData as [String: Any])
                    
                    self.setDataInDocument(data: [self.documentName: dataArray], completion: completion)
                } catch {
                    completion("Error encoding object: \(error.localizedDescription)")
                }
            } else {
                do {
                    let objectData = try Firestore.Encoder().encode(object)
                    let data = [self.documentName: [objectData as [String: Any]]]
                    
                    self.setDataInDocument(data: data, completion: completion)
                } catch {
                    completion("Error encoding object: \(error.localizedDescription)")
                }
            }
        }
    }
    
    public func setArrayObject<T: Encodable>(_ objects: [T], completion: @escaping (String) -> Void) {
        do {
            var dataArray = [[String: Any]]()
            
            for object in objects {
                let objectData = try Firestore.Encoder().encode(object)
                dataArray.append(objectData as [String: Any])
            }
            
            let data = [self.documentName: dataArray]
            
            self.setDataInDocument(data: data, completion: completion)
        } catch {
            completion("Error encoding objects: \(error.localizedDescription)")
        }
    }
    
    public func deleteObjectInArray(index: Int, completion: @escaping (String) -> Void) {
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataArray = document.data()?[self.documentName] as? [[String: Any]] ?? []
                
                // Verificar se o índice fornecido está dentro dos limites do array
                guard index >= 0 && index < dataArray.count else {
                    completion("Invalid index provided")
                    return
                }
                
                dataArray.remove(at: index)
                
                self.setDataInDocument(data: [self.documentName: dataArray], completion: completion)
            } else {
                completion("Document does not exist")
            }
        }
    }
    
    public func getObjectsArrayData<T: Codable>(forObjectType objectType: T.Type, documentReadName: String, completion: @escaping (Result<[T], Error>) -> Void) {
        db.collection(user).document(documentReadName).getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                let emptyArray: [T] = []
                completion(.success(emptyArray))
                return
            }
            
            if let data = document.data(), let objectsReadData = data[documentReadName] as? [[String: Any]] {
                
                var objectList: [T] = []
                
                for rawObject in objectsReadData {
                    do {
                        let object = try Firestore.Decoder().decode(T.self, from: rawObject)
                        objectList.append(object)
                    } catch {
                        //print("Error decoding goal: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                completion(.success(objectList))
            } else {
                completion(.success([]))
            }
        }
    }
    
    private func setDataInDocument(data: [String: Any], completion: @escaping (String) -> Void) {
        let docRefSet = db.collection(user).document(documentName)
        docRefSet.setData(data) { error in
            if let error = error {
                completion("Error writing document: \(error.localizedDescription)!")
            } else {
                completion("Success")
            }
        }
    }
    
    public func setObject<T: Encodable>(_ object: T, documentName: String, completion: @escaping () -> Void) {
        do {
            let objectData = try Firestore.Encoder().encode(object) // Converte o objeto goal em um dicionário
            let data: [String: Any] = [documentName: objectData] // Cria um dicionário com o campo "objeto1" contendo o objeto goal

            db.collection(user).document(documentName).setData(data)
            completion()
        } catch let error {
            print("Error writing document: \(error.localizedDescription)!")
            completion()
        }
    }
    
    public func getObject<T: Decodable>(documentName: String, objectType: T.Type, completion: @escaping (T?) -> Void) {
        db.collection(user).document(documentName).getDocument { (document, error) in
            if let document = document, document.exists {
                guard let documentData = document.data(), let objectData = documentData[documentName] as? [String: Any] else {
                    completion(nil)
                    return
                }
                do {
                    let object = try Firestore.Decoder().decode(objectType, from: objectData)
                    completion(object)
                } catch let error {
                    print("Error decoding document: \(error.localizedDescription)!")
                    completion(nil)
                }
            } else {
                print("Document does not exist!")
                completion(nil)
            }
        }
    }
}
