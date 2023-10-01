import Foundation
import UIKit

class PlayedTrackView: UIView {
    private var isPlaying = false {
        didSet{
            playPauseButton.isSelected = isPlaying
        }
    }
    
    private lazy var musicImage: UIImageView = {
        let image = UIImageView(cornerRadius: 20)
        image.backgroundColor = .systemPink
        return image
    }()
    
    private lazy var musicLabel = UILabel(text: "Моя тень и я", font: .systemFont(ofSize: 15), textColor: .darkGray, textAlignment: .center)
    
    private lazy var buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 15
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.addTarget(self, action: #selector(backwardButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "pause.fill")?.withConfiguration(config), for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.addTarget(self, action: #selector(forwardButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 205/255, green: 220/255, blue: 250/255, alpha: 1)
        self.layer.cornerRadius = 12
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.addSubviews(musicImage, musicLabel, buttonsStackView)
        buttonsStackView.addArrangedSubviews(backwardButton, playPauseButton, forwardButton)
        
        NSLayoutConstraint.activate([
            musicImage.heightAnchor.constraint(equalToConstant: 40),
            musicImage.widthAnchor.constraint(equalToConstant: 40),
            musicImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            musicImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            musicLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            musicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    
    
    @IBAction private func backwardButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction private func playPauseButtonPressed(_ sender: UIButton) {
        isPlaying.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        if isPlaying {
            sender.setImage(UIImage(systemName: "pause.fill")?.withConfiguration(config), for: .normal)
        } else{
            sender.setImage(UIImage(systemName: "play.fill")?.withConfiguration(config), for: .normal)
        }

    }
    
    @IBAction private func forwardButtonPressed(_ sender: UIButton) {
        
    }
}
