//
//  Servisable.swift
//  PodcastApp
//
//  Created by sidzhe on 03.10.2023.
//

import Foundation

//MARK: - Protocol Servisable

protocol Serviceable {
    func getPodcast<T: Decodable>(search: String) async -> Result<T, RequestError>
    func getRecent<T: Decodable>() async -> Result<T, RequestError>
}
