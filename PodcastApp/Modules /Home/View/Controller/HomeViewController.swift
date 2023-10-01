import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        navigationItem.title = "Loktionov Vlad"
        setupUI()
        setupImage()
    }
    

    private func setupImage() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        for subview in navigationBar.subviews {
            if NSStringFromClass(subview.classForCoder).contains("UINavigationBarLargeTitleView") {
                subview.addSubview(userImage)
                NSLayoutConstraint.activate([
                    userImage.rightAnchor.constraint(equalTo: subview.rightAnchor, constant: -20),
                    userImage.bottomAnchor.constraint(equalTo: userImage.superview?.bottomAnchor ?? navigationBar.bottomAnchor, constant: -10),
                    userImage.heightAnchor.constraint(equalToConstant: 36),
                    userImage.widthAnchor.constraint(equalToConstant: 36)
                ])
            }
        }
    }
    

    @IBAction private func seeAllButtonPressed(_ sender: UIButton) {
        print("See all button pressed")
    }
    
    private func setupUI() {
        view.addSubview(homeTableView)
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
            return 400
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
            return 10
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
