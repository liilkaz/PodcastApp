import UIKit

class SearchViewController: UIViewController {
    
    private var searchViewModel = SearchViewModel()
    
    private lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "SearchBG")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TopGenreCollection.self, forCellReuseIdentifier: TopGenreCollection.identifier)
        tableView.register(BrowseAllCollection.self, forCellReuseIdentifier: BrowseAllCollection.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.layer.masksToBounds = true
        bar.layer.cornerRadius = 12
        return bar
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .customGray2
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func rightButtonTapped() {
        searchBar.resignFirstResponder()
        rightButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        rightButton.tintColor = .customGray2
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    private func setupSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Podcast, channel, or artists"
        searchTextField.font = .regular14()
        searchTextField.leftView = nil
        searchTextField.rightView = rightButton
        searchTextField.rightViewMode = .always
        searchTextField.layer.borderColor = UIColor.black.cgColor
      
        searchBar.barTintColor = .white
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupSearchBar()
        setupUI()
        addTapGesture()
        navigationItem.title = "Search"

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(searchTableView, searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 48),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            // MARK: По идее можно получить  число жанров из апишки, умножить на (высоту ячейки +17) и разделить на два(сколько в ряду), но пока такое число, чтобы не резалось и влезало все.
            return 450
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
            return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopGenreCollection.identifier, for: indexPath) as! TopGenreCollection
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BrowseAllCollection.identifier, for: indexPath) as! BrowseAllCollection
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: TapGenresCollectionPressed {
    func tapGenreCollection(with title: String) {
        let vc = SearchResultsViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.searchTerm = title
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension SearchViewController: BrowseAllButtonPressed {
    func browseAllCollection(with title: String) {
        let vc = SearchResultsViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.searchTerm = title
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension SearchViewController : UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            rightButton.setImage(UIImage(named: "Search"), for: .normal)
        } else {
            rightButton.setImage(UIImage(systemName: "xmark.square"), for: .normal)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchInput = searchBar.text, !searchInput.isEmpty {
            let vc = SearchResultsViewController()
            vc.searchTerm = searchInput
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        } else {
            searchBar.searchTextField.placeholder = "Type something"
        }
    }
}

