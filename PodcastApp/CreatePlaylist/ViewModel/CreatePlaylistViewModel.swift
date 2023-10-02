//
//  CreatePlaylistViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import UIKit

final class CreatePlaylistViewModel: CreatePlaylistProtocol {
    
    //MARK: - Properties
    
    var networkService = NetworkService()
    var eventHandler: ((_ event: Event) -> Void)? 
        
    private var model: [Item]?
    
    //MARK: - Methods
    
    func getRowsCount() -> Int {
        return model?.count ?? 0
    }
    
    func getModel(_ indexPath: IndexPath) -> CreatePlaylistCellProtocol? {
        guard let model = model?[indexPath.row] else { return nil }
        return CreatePlaylistCellViewModel(podcastModel: model)
    }
    
    func fetch() {
        
        self.eventHandler?(.loading)
        
        networkService.searchRecent { [weak self] (result: Result<PodcastModel, RequestError>) in
            
            guard let self else { return }
            
            self.eventHandler?(.stopLoading)
            
            switch result {
                
            case .success(let data):
                guard let item = data.items else { return }
                self.model = item
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func searchRequest(_ search: String?) {
        
        guard let text = search else { return }
        
        networkService.searchPodcast(search: text) { [weak self] (result: Result<PodcastModel, RequestError>) in
            guard let self else { return }
            
            switch result {
                
            case .success(let data):
               
                guard let item = data.items else { return }
                self.model = item
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
