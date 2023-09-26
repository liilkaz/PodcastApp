//
//  PlaylistViewController.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit
import SnapKit

final class PlaylistViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: PlaylistViewModelProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, FavoritesModel>?
    
    //MARK: - UI Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Playlist"
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
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PlaylistViewModel()
        setupViews()
        configureCollectionView()
        createDataSourse()
        applySnapshot()
        
    }
    
    //MARK: - setupViews
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(headerLabel)
        view.addSubview(additionallyButton)
        
        headerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        additionallyButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.right.equalToSuperview().inset(32)
        }
    }
    
    @objc private func tapButton() {
        print("Tap button")
    }
}


//MARK: - extension PlaylistViewController

extension PlaylistViewController {
    
    //MARK: - configureCollectionView
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).inset(-26)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    //MARK: - Create Layout
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .favorites {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(160))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 30, bottom: 8, trailing: 0)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .playlist {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 30, bottom: 8, trailing: 0)
                
                ///header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else {
                fatalError("Unknown section!")
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: - Registration
    
    private func registrFavorites() -> UICollectionView.CellRegistration<FavoritesListCell, FavoritesModel> {
        return UICollectionView.CellRegistration<FavoritesListCell, FavoritesModel> { [weak self] (cell, indexPath, item) in
            let model = self?.viewModel?.getFavoritesModel(indexPath: indexPath)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 16
            cell.backgroundColor = .systemMint
            cell.viewModel = model
        }
    }
    
    private func registrPlaylist() -> UICollectionView.CellRegistration<FavoritsCell, FavoritesModel> {
        return UICollectionView.CellRegistration<FavoritsCell, FavoritesModel> { [weak self] (cell, indexPath, label) in
            let model = self?.viewModel?.getPlaylistModel(indexPath: indexPath)
            cell.viewModel = model
        }
    }
    
    private func registrFavoritesHeader() -> UICollectionView.SupplementaryRegistration<HeaderCell> {
        return UICollectionView.SupplementaryRegistration<HeaderCell>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            
        }
    }
    
    private func registrPlaylistHeaher() ->  UICollectionView.SupplementaryRegistration<HeaderPlaylist> {
        return UICollectionView.SupplementaryRegistration<HeaderPlaylist>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            
        }
    }
    
    //MARK: - create dataSource
    
    private func createDataSourse() {
        
        let favoritesCell = registrFavorites()
        let playlistCell = registrPlaylist()
        let headerFavorites = registrFavoritesHeader()
        let headerPlaylist = registrPlaylistHeaher()
        
        dataSource = UICollectionViewDiffableDataSource<Section, FavoritesModel>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .favorites:
                    return collectionView.dequeueConfiguredReusableCell(using: favoritesCell, for: indexPath, item: item)
            case .playlist:
                return collectionView.dequeueConfiguredReusableCell(using: playlistCell, for: indexPath, item: item)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Section(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .favorites:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: headerFavorites, for: indexPath)
                    case .playlist:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: headerPlaylist, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: - Snapshots
    
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, FavoritesModel>()
        snapshot.appendSections([.favorites, .playlist])
        
        guard let model = viewModel?.favoritesArray(), let model2 = viewModel?.playlistArray() else { return }
        
        snapshot.appendItems(model, toSection: .favorites)
        snapshot.appendItems(model2, toSection: .playlist)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


