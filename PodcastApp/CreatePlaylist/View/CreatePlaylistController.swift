//
//  CreatePlaylistController.swift
//  PodcastApp
//
//  Created by sidzhe on 05.10.2023.
//

import UIKit
import SnapKit

final class CreatePlaylistController: UIViewController {
    
    //MARK: - Properties
    
    private let identifier = "createPlw"
    private var viewModel: CreatePlaylistProtocol?
    
    //MARK: - UI Elements
    
    private lazy var lineView = UIView()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapAddImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.backgroundColor = .customGray
        image.image = UIImage(named: "defImage")
        return image
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField()
        text.borderStyle = .none
        text.placeholder = "Give a name for your playlist"
        text.clearButtonMode = .always
        text.textAlignment = .center
        text.delegate = self
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
        search.delegate = self
        search.searchTextField.backgroundColor = .customGray
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
    
    //MARK: - Inits
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.fetch()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel = CreatePlaylistViewModel()
        observeEvent()
        
    }
    
    //MARK: - Properties
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        lineView.layer.addSublayer(line)

        view.addSubview(iconImage)
        view.addSubview(textField)
        view.addSubview(lineView)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(addImageButton)
                
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(84)
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        addImageButton.snp.makeConstraints { make in
            make.size.equalTo(84)
            make.center.equalTo(iconImage.snp.center)
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
    
    private func observeEvent() {
        
        viewModel?.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .dataLoaded:
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .error(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    @objc private func tapButton() {
        print("Tap button")
    }
    
    @objc private func tapAddImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

//MARK: - Extensoin UICollectionViewDataSource

extension CreatePlaylistController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getRowsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CreatePlaylistCell
        let model = viewModel?.getModel(indexPath)
        cell?.viewModel = model
        cell?.backgroundColor = .customGray
        cell?.clipsToBounds = true
        cell?.layer.cornerRadius = 16
        return cell ?? UICollectionViewCell()
    }
}


//MARK: - Extension UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension CreatePlaylistController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocument().appendingPathExtension(imageName)
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: imagePath)
            self.iconImage.image = UIImage(data: data)
        }
        
        dismiss(animated: true)
    }
    
    func getDocument() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//MARK: - Extension UISearchBarDelegate

extension CreatePlaylistController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.searchRequest(searchBar.text)
        searchBar.resignFirstResponder()
    }
}


//MARK: - Extension UITextFieldDelegate

extension CreatePlaylistController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
