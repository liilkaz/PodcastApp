//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//
import UIKit

class SearchViewController: UIViewController {
    
    var searchInput: String = ""
    
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
        button.setImage(UIImage(named: "Search"), for: .normal)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func rightButtonTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        rightButton.setImage(UIImage(named: "Search"), for: .normal)
    }
    
    private func setupSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Podcast, channel, or artists"
        searchTextField.font = .regular14()()
        searchTextField.leftView = nil
        searchTextField.rightView = rightButton
        searchTextField.rightViewMode = .always
      
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
        navigationItem.title = "Search"
        navigationItem.hidesBackButton = true
    }
    
    private func setupUI() {
        view.addSubviews(bgView)
        view.addSubviews(searchTableView)
        view.addSubviews(searchBar)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
    
    //    private func setupSearchBar() {
    //        let searchTextField = searchBar.searchTextField
    //        searchTextField.backgroundColor = .white
    //        searchTextField.placeholder = "Search"
    //        searchBar.showsBookmarkButton = true
    //        searchTextField.leftView = nil
    ////        if let button = searchTextField.rightView as? UIButton {
    ////            button.setImage(UIImage(named: "Search"), for: .normal)
    ////            button.setImage(UIImage(named: "Search"), for: .highlighted
    ///}
    //        searchBar.barTintColor = .white
    //        searchBar.delegate = self
    //    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            return 600
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
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BrowseAllCollection.identifier, for: indexPath) as! BrowseAllCollection
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        default: break
        }
        return UITableViewCell()
    }
}

extension SearchViewController : UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            rightButton.setImage(UIImage(named: "Search"), for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "Close"), for: .normal)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchInput = searchBar.text, !searchInput.isEmpty {
            self.searchInput = searchInput
            let vc = SearchResultsViewController()
            vc.searchTerm = searchInput
            navigationController?.pushViewController(vc, animated: true)
        } else {
            searchBar.searchTextField.placeholder = "Type something"
        }
    }
}




