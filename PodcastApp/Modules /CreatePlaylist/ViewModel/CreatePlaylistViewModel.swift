import UIKit

final class CreatePlaylistViewModel: CreatePlaylistProtocol {

    //MARK: - Properties
    
    var networkService = NetworkService()
    var eventHandler: ((_ event: Event) -> Void)?

    private var model: [Item]?
    private var saveModel = [SavePlaylistModel]()
    private var indexPath = [Int]()

    //MARK: - Methods
    
    func getRowsCount() -> Int {
        return model?.count ?? 0
    }

    func getModel(_ indexPath: IndexPath) -> CreatePlaylistCellProtocol? {
        guard let model = model?[indexPath.row] else { return nil }
        return CreatePlaylistCellViewModel(podcastModel: model)
    }

    func addIndex(state: Bool, index: Int) {

        if state {
            self.indexPath.append(index)
        }
    }

    func fetch() {

        networkService.searchRecent { [weak self] (result: Result<PodcastModel, RequestError>) in

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


    func savePlaylist(playlistName: String?, icon: UIImage?) {

        var saveElements = [Item]()

        guard let icon = icon,
              let playlistName = playlistName,
              let model = model else { return }

        self.indexPath.forEach({ index in
            let element = model[index]
            saveElements.append(element)
        })

        let save = SavePlaylistModel(image: icon, playlistName: playlistName, playlist: saveElements)
        self.saveModel.append(save)
        //MARK: - Добавить метод сохранения и загрузки в realm
    }
}
