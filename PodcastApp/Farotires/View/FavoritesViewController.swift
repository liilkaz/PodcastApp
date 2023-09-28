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
    var networkService =  NetworkService()
    
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
        layout.itemSize = CGSize(width: view.frame.size.width - 92, height: 60)
        layout.minimumLineSpacing = 20
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
        
//       networkService.searchPodcast(search: "sport") { [weak self] (result: Result<MainModel, RequestError>) in
//            switch result {
//                
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error.customMessage)
//            }
//        }
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
 
        view.addSubview(headerLabel)
        view.addSubview(additionallyButton)
        view.addSubview(collectionView)
        
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        additionallyButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.right.equalToSuperview().inset(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).inset(-26)
            make.horizontalEdges.equalToSuperview().inset(46)
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
