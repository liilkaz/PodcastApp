//
//  PodcastService.swift
//  PodcastApp
//
//  Created by sidzhe on 03.10.2023.
//

import Foundation

//MARK: - Podcast Service

struct PodcastService: PodcastClient, Serviceable {
    
    func getPodcast<T: Decodable>(search: String) async -> Result<T, RequestError> {
        return await sendRequest(endpoint: PodcastEndpoint.serchPodcast, responseModel: T.self, search: search)
    }
    
    func getRecent<T: Decodable>() async -> Result<T, RequestError> {
        return await sendRecentRequest(endpoint: PodcastEndpoint.recent, responseModel: T.self)
    }
}

