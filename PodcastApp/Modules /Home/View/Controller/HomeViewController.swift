import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    var items: [Item] = []
    
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        homeTableView.reloadData()
    }
    
    @IBAction private func seeAllButtonPressed(_ sender: UIButton) {
        print("See all button pressed")
    }
    
    private func setupUI() {
        view.addSubviews(homeTableView)
        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 430
        case 1:
            return 90
        default: break
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return items.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            cell.categoryDelegate = self
            cell.tagDelegate = self
            cell.selectionStyle = .none
            return cell
        case 1:
            let item = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.configureCell(with: item)
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ids = items.compactMap { $0.feedID }
        let urlMusics = items.compactMap { $0.enclosureURL }
        let images = items.compactMap { $0.feedImage }
        let titles = items.compactMap { $0.feedTitle }
        let creators = items.compactMap { $0.feedAuthor }
        
        let model = NowPlayingViewModel(podcastId: ids, podcastMusic: urlMusics, podcastImage: images, podcastTitle: titles, podcastCreator: creators)
        let nowPlayingVC = NowPlayingViewController(nowPlayingModel: model, tracks: urlMusics, currentTrack: indexPath.row)
        nowPlayingVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nowPlayingVC, animated: true)
    }
}

extension HomeViewController: CategoryTagPressedDelegate {
    func categoryTagPressed(with model: [Item]) {
        DispatchQueue.main.async{
            self.items = model
            self.homeTableView.reloadData()
        }
    }
}

extension HomeViewController: CategoryPressedDelegate {
    func categoryPressed(with model: ChannelModel) {
        let channelModel = ChannelViewModel(channelModel: model)
        let vc = ChannelViewController(channelViewModel: channelModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
