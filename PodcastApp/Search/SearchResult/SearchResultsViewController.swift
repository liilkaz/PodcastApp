//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//
import UIKit

class SearchResultsViewController: UIViewController, UISearchBarDelegate {
    
    var searchTerm = ""

    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.register(AllPodcastsCell.self, forCellReuseIdentifier: AllPodcastsCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubviews(searchTableView)
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        case 1:
            return 90
        case 2:
            return 90
        default: break
        }
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            return 10
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            return UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllPodcastsCell.identifier, for: indexPath) as! AllPodcastsCell
            cell.selectionStyle = .none
            return cell
        default: break
        }
        return UITableViewCell()
    }

    func createSectionHeaderView(withTitle title: String, font: UIFont? = .regular14(), button: UIButton?, separatorNeeded: Bool = false, tableView: UITableView) -> UIView {
        let headerView = UIView()
        let label = UILabel(text: "", font: font, textColor: .black)
        headerView.addSubviews(label)

        if let button = button {
            button.setImage(UIImage(named: "Close"), for: .normal)
            button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            headerView.addSubviews(button)
        }

        label.text = title

        setupHeaderUI(headerView, label: label, button: button, separatorNeeded: separatorNeeded, tableView: tableView)

        return headerView
    }

    func setupHeaderUI(_ headerView: UIView, label: UILabel, button: UIButton?, separatorNeeded: Bool, tableView: UITableView) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 6),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
        ])

        if let button = button {
            NSLayoutConstraint.activate([
                button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
                button.centerYAnchor.constraint(equalTo: label.centerYAnchor)
            ])
        }

        if separatorNeeded {
            let separatorView = UIView()
            separatorView.backgroundColor = tableView.separatorColor
            headerView.addSubviews(separatorView)

            NSLayoutConstraint.activate([
                separatorView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                separatorView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                separatorView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 18),
//                separatorView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1) // Высота нижнего разделителя
            ])
        }
    }

    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
        }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let button = UIButton(type: .custom)
            return createSectionHeaderView(withTitle: searchTerm, button: button, separatorNeeded: true, tableView: tableView)
        case 1:
            return createSectionHeaderView(withTitle: "Search Results", font: .bold14(), button: nil, tableView: tableView)
        case 2:
            return createSectionHeaderView(withTitle: "All Podcasts", button: nil, tableView: tableView)
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        } else {
            return 32
        }
    }
}


    




