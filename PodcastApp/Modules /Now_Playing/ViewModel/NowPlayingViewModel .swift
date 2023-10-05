import Foundation
import UIKit

class NowPlayingViewModel {
    var networkService = NetworkService()
    var podcastMusic: String?
    var podcastImage: String?
    var podcastTitle: String?
    var podcastCreator: String?
    
    init(podcastMusic: String?, podcastImage: String?, podcastTitle: String?, podcastCreator: String?) {
        self.podcastMusic = podcastMusic
        self.podcastImage = podcastImage
        self.podcastTitle = podcastTitle
        self.podcastCreator = podcastCreator
    }
}
