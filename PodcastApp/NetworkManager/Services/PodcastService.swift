//
//  PodcastService.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

//MARK: - Podcast Service

struct PodcastService: PodcastClient, Serviceable {
    
    func getPodcast<T: Decodable>(search: String) async -> Result<T, RequestError> {
        return await sendRequest(endpoint: PodcastEndpoint.serchPodcast, responseModel: T.self, search: search)
    }
}

