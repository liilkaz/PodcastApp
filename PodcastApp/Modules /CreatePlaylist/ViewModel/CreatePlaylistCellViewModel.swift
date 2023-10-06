import UIKit

final class CreatePlaylistCellViewModel: CreatePlaylistCellProtocol {

    //MARK: - Properties
    
    private var podcastModel: Item
    private var networkService = NetworkService()

    var songName: String { podcastModel.title ?? "" }
    var contentName: String { podcastModel.feedTitle ?? "" }
    var icon: ObserverBox<UIImage?> = ObserverBox(value: nil)

    //MARK: - Init
    
    init(podcastModel: Item) {
        self.podcastModel = podcastModel
        loadImage(from: podcastModel.feedImage)
    }

    private func loadImage(from urlString: String?) {
        guard let urlString else { return }
        Task { self.icon.value = try await networkService.loadImageTask(from: urlString) }
    }
}
