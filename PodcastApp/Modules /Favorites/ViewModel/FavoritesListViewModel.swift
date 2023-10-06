import UIKit

final class FavoritesListViewModel: FavoritsCellViewModelProtocol {

    //MARK: - Properties
    
    var icon: ObserverBox<UIImage?> = ObserverBox(value: nil)
    var songName: String { favoritesModel.title ?? "" }
    var contentName: String { favoritesModel.feedTitle ?? "" }

    private var favoritesModel: Item
    private let networkService = NetworkService()
    //MARK: - Init
    init(favoritesModel: Item) {
        self.favoritesModel = favoritesModel
        self.loadImage(from: favoritesModel.feedImage)
    }

    private func loadImage(from urlString: String?) {
        guard let urlString else { return }
        Task { self.icon.value = try await networkService.loadImageTask(from: urlString) }
    }
}
