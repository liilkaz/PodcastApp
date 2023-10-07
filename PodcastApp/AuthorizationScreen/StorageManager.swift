//
//  StorageManager.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 07.10.2023.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        storage.child("image/\(fileName)").putData(data) { metadata, error in
            guard error == nil else {
                completion(.failure(StorageErrors.failedToUpload))
                return
        }
            self.storage.child("image/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        }
    }
}
