import Foundation

class FavoritesViewModel {
    var realmService = RealmService()
    var favorites = [ItemPodcastModel]()
    
    func fetchFavoritesPodcast() {
        self.favorites = realmService.loadFavoritesPodcastFromRealm()
    }
}
