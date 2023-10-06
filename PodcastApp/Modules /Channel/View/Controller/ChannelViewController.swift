import UIKit

class ChannelViewController: UIViewController {
    var channelViewModel: ChannelViewModel
    private lazy var channelTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChannelMusicInfoTableViewCell.self, forCellReuseIdentifier: ChannelMusicInfoTableViewCell.identifier)
        tableView.register(AllEpisodeTableViewCell.self, forCellReuseIdentifier: AllEpisodeTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(channelViewModel: ChannelViewModel) {
        self.channelViewModel = channelViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBarWithBackButton(title: channelViewModel.channelModel.title)
        setupUI()
        fetctPodcasts()
    }
    
    private func fetctPodcasts() {
        channelViewModel.fetchPodcast(with: channelViewModel.channelModel.title) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.channelTableView.reloadData()
                case .failure:
                    print("Failure")
                }
            }
            
        }
    }
    
    private func setupUI() {
        view.addSubviews(channelTableView)
        NSLayoutConstraint.activate([
            channelTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            channelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            channelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            channelTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ChannelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 250
        case 1: return 90
        default: break
        }
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return ChannelHeaderView()
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return channelViewModel.channelItem.count
        default: break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChannelMusicInfoTableViewCell.identifier, for: indexPath) as! ChannelMusicInfoTableViewCell
            cell.configureCell(with: channelViewModel.channelModel)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllEpisodeTableViewCell.identifier, for: indexPath) as! AllEpisodeTableViewCell
            cell.configure(with: channelViewModel.channelItem[indexPath.row])
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }
}

extension ChannelViewController: UITableViewDelegate {}
