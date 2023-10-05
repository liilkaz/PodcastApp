//
//  HTTPClient.swift
//  PodcastApp
//
//  Created by sidzhe on 03.10.2023.
//

import Foundation

//MARK: - PodcastClient

protocol PodcastClient {
    func sendRequest<T: Decodable>(endpoint: PodcastEndpoint, responseModel: T.Type, search: String) async -> Result<T, RequestError>
    func sendRecentRequest<T: Decodable>(endpoint: PodcastEndpoint, responseModel: T.Type) async -> Result<T, RequestError>
}


//MARK: - Extension PodcastClientProtocol

extension PodcastClient {
    
    func sendRequest<T: Decodable>(endpoint: PodcastEndpoint, responseModel: T.Type, search: String) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = [URLQueryItem(name: "q", value: search), URLQueryItem(name: "max", value: "7"), URLQueryItem(name: "pretty", value: nil)]
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
      
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
                do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func sendRecentRequest<T: Decodable>(endpoint: PodcastEndpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
                do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
                    
            switch response.statusCode {
                
            case 200...299:
                
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
