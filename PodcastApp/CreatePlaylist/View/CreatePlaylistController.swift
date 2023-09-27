//
//  CreatePlaylistController.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import UIKit
import SnapKit

final class CreatePlaylistController: UIViewController {
    
    //MARK: - Properties
    
    private let identifier = "createPlw"
    private var viewModel: CreatePlaylistProtocol?
    
    //MARK: - UI Elements
    
    private lazy var lineView = UIView()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Playlist"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var additionallyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.setImage(UIImage(named: "ellipsisVert"), for: .normal)
        return button
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.image = UIImage(systemName: "swift")
        return image
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField()
        text.borderStyle = .none
        text.placeholder = "Give a name for your playlist"
        text.clearButtonMode = .always
        text.textAlignment = .center
        return text
    }()
    
    private lazy var line: CALayer = {
        let line = CALayer()
        line.backgroundColor = UIColor.systemGray3.cgColor
        line.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 64, height: 1.0)
        return line
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.placeholder = "Search..."
        return search
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width - 64, height: 72)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CreatePlaylistCell.self, forCellWithReuseIdentifier: identifier)
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel = CreatePlaylistViewModel()
        
    }
    
    //MARK: - Properties
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        lineView.layer.addSublayer(line)
        
        view.addSubview(headerLabel)
        view.addSubview(additionallyButton)
        view.addSubview(iconImage)
        view.addSubview(textField)
        view.addSubview(lineView)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        additionallyButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.right.equalToSuperview().inset(32)
        }
        
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(84)
            make.top.equalTo(headerLabel.snp.bottom).inset(-33)
            make.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(iconImage.snp.bottom).inset(-24)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(textField.snp.bottom).inset(-12)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).inset(-20)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func tapButton() {
        print("Tap button")
    }
}

extension CreatePlaylistController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getRowsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CreatePlaylistCell
        let model = viewModel?.getModel(indexPath)
        cell?.viewModel = model
        cell?.backgroundColor = .systemGray4
        cell?.clipsToBounds = true
        cell?.layer.cornerRadius = 16
        return cell ?? UICollectionViewCell()
    }
}
