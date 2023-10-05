//
//  PlaylistViewController.swift
//  PodcastApp
//
//  Created by sidzhe on 05.10.2023.
//

import UIKit
import SnapKit

final class PlaylistViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: PlaylistViewModelProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, PlaylistModel>?
    
    //MARK: - Inits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PlaylistViewModel()
        configureCollectionView()
        createDataSourse()
        applySnapshot()
        observeEvent()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.fetch()
        
    }
    
    //MARK: - Observer event
    
    private func observeEvent() {
        
        viewModel?.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .dataLoaded:
                Task { self.applySnapshot() }
            case .error(let error):
                print(error?.localizedDescription ?? "")
            }
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 64, bottom: 8, trailing: 0)
                
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 32, bottom: 0, trailing: 62)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 32, bottom: 8, trailing: 0)
                
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
    
    private func registrFavorites() -> UICollectionView.CellRegistration<FavoritesListCell, PlaylistModel> {
        return UICollectionView.CellRegistration<FavoritesListCell, PlaylistModel> { [weak self] (cell, indexPath, item) in
            guard let self else { return }
            let model = self.viewModel?.getFavoritesModel(indexPath: indexPath)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 16
            cell.backgroundColor = self.viewModel?.getColorfull(indexPath.row)
            cell.viewModel = model
        }
    }
    
    private func registrPlaylist() -> UICollectionView.CellRegistration<FavoritsCell, PlaylistModel> {
        return UICollectionView.CellRegistration<FavoritsCell, PlaylistModel> { [weak self] (cell, indexPath, label) in
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
            header.completionHandler = { [weak self] in
                guard let self else { return }
                self.present(CreatePlaylistController(), animated: true) }
        }
    }
    
    //MARK: - create dataSource
    
    private func createDataSourse() {
        
        let favoritesCell = registrFavorites()
        let playlistCell = registrPlaylist()
        let headerFavorites = registrFavoritesHeader()
        let headerPlaylist = registrPlaylistHeaher()
        
        dataSource = UICollectionViewDiffableDataSource<Section, PlaylistModel>(collectionView: collectionView) {
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, PlaylistModel>()
        snapshot.appendSections([.favorites, .playlist])
        
        guard let model = viewModel?.favoritesArray(), let model2 = viewModel?.playlistArray() else { return }
        
        snapshot.appendItems(model.map { PlaylistModel(favorites: $0)}, toSection: .favorites)
        snapshot.appendItems(model2.map { PlaylistModel(playlist: $0)}, toSection: .playlist)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
