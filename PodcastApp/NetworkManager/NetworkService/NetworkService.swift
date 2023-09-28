//
//  NetworkService.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

//MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    func searchPodcast<T: Decodable>(search: String, completion: @escaping (Result<T, RequestError>) -> Void)
}

//MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {
    
    private let service = PodcastService()
    
    func searchPodcast<T>(search: String, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.getPodcast(search: search)
            completion(result)
        }
    }
}
