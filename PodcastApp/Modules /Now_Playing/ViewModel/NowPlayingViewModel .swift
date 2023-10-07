import Foundation
import UIKit

class NowPlayingViewModel {
    var networkService = NetworkService()
    var realmService = RealmService()
    var podcastId: [Int]
    var podcastMusic: [String]
    var podcastImage: [String]
    var podcastTitle: [String]
    var podcastCreator: [String]
    
    init(podcastId: [Int], podcastMusic: [String], podcastImage: [String], podcastTitle: [String], podcastCreator: [String]) {
        self.podcastId = podcastId
        self.podcastMusic = podcastMusic
        self.podcastImage = podcastImage
        self.podcastTitle = podcastTitle
        self.podcastCreator = podcastCreator
    }
}
