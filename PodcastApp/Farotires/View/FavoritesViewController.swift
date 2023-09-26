//
//  FavoritesViewController.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: FavoritesViewModelProtocol?
    private let identifier = "cell"
    
    //MARK: - UI Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var additionallyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.setImage(UIImage(named: "ellipsisVert"), for: .normal)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: 80)
        layout.minimumLineSpacing = 24
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(FavoritsCell.self, forCellWithReuseIdentifier: identifier)
        view.dataSource = self
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel = FavoritesViewModel()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
 
        view.addSubview(headerLabel)
        view.addSubview(additionallyButton)
        view.addSubview(collectionView)
        
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        additionallyButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.right.equalToSuperview().inset(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func tapButton() {
        print("Tap button")
    }
}


//MARK: - Extension UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getRowsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FavoritsCell
        let model = viewModel?.getModel(indexPath: indexPath)
        cell?.viewModel = model
        return cell ?? UICollectionViewCell()
    }
}
