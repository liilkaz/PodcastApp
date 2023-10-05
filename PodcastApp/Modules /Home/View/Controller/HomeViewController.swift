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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Profile"
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
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1:
            let item = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.configureCell(with: items[indexPath.row])
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathRow = items[indexPath.row]
        let model = NowPlayingViewModel(podcastMusic: indexPathRow.enclosureURL, podcastImage: indexPathRow.feedImage, podcastTitle: indexPathRow.feedTitle, podcastCreator: indexPathRow.feedAuthor)
        let nowPlayingVC = NowPlayingViewController(nowPlayingModel: model)
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
