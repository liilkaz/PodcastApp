//
//  DatabaseManager.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 06.10.2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    public func insertUser(with user: UserDataBase, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
        { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        self.database.child("users").observeSingleEvent(of: .value) { snapshot in
            if var usersCollection = snapshot.value as? [[String: String]] {
                // append to user dictionary
                let newElement = [
                    "name": user.firstName + " " + user.lastName,
                    "email": user.safeEmail
                ]
                usersCollection.append(newElement)
                
                self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    
                    completion(true)
                })
            } else {
                // create that array
                let newCollection: [[String: String]] = [
                    [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                ]

                self.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }

                    completion(true)
                })
            }
        }
    }
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        
        var safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false )
                return
            }
            completion(true)
        }
    }
    
    public func getDataFor(path: String, completion: @escaping (Result<Any, Error>) -> Void) {
            database.child("\(path)").observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value else {
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }
                completion(.success(value))
            }
        }
    
    public func getFullName(email: String) -> String? {
        var name = ""
        database.child(email).getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
              }
            let userName = snapshot?.value as? String ?? "Unknown"
            print(userName)
            name = userName
        }
        return name
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
        
    }
    
}

struct UserDataBase {
    let firstName: String
    let lastName: String
    let email: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
//    let dateOfBirth: String
//    let image: String
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
