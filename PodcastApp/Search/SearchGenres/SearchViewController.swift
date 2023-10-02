//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//
import UIKit

class SearchViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TopGenreCell.self, forCellReuseIdentifier: TopGenreCell.identifier)
        tableView.register(BrowseAllCell.self, forCellReuseIdentifier: BrowseAllCell.identifier)
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
        navigationItem.title = "Search"
    }
    
    
    private func setupUI() {
        view.addSubviews(searchTableView)
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TopGenreCell.identifier, for: indexPath) as! TopGenreCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BrowseAllCell.identifier, for: indexPath) as! BrowseAllCell
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }
}




