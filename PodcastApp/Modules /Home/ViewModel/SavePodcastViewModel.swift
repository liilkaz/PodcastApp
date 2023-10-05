import Foundation

class SavePodcastViewModel {
    var networkService = NetworkService()
    var realmDatabase = RealmService()
    var podcastItem: Item?
}
