//
//  NetworkService.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import UIKit

//MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    func searchPodcast<T: Decodable>(search: String, completion: @escaping (Result<T, RequestError>) -> Void)
    func searchRecent<T: Decodable>(completion: @escaping (Result<T, RequestError>) -> Void)
    func loadImageTask(from urlString: String) async throws -> UIImage
}

//MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {
    
    private let service = PodcastService()
    
    //MARK: - searchPodcast
    
    func searchPodcast<T>(search: String, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.getPodcast(search: search)
            completion(result)
        }
    }
    
    //MARK: - searchRecent
    
    func searchRecent<T>(completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        
        Task(priority: .background) {
            let result: Result<T, RequestError> = await service.getRecent()
            completion(result)
        }
    }
    
    //MARK: - Load image
    
    func loadImageTask(from urlString: String) async throws -> UIImage {
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL)}
        
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            if let image = UIImage(data: cachedResponse.data) {
                return image
            }
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse)}
        guard response.statusCode == 200 else { throw URLError(.badServerResponse)}
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData)}
        
        let cachedData = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedData, for: request)
        
        return image
    }
}

