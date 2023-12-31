import UIKit

class NowPlayingViewController: UIViewController {
    var nowPlayingViewModel: NowPlayingViewModel
    var musicPlayerViewModel: MusicPlayerViewModel
    var currentTrack = 0
    private var isSliderBeingDragged = false

    private var isPlaying = true {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }

    private lazy var musicImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.image = UIImage(named: "books")
        return image
    }()
    
    private lazy var musicLabel = UILabel(text: "Мне это не нужно", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    private lazy var creatorLabel = UILabel(text: "Kizaru", font: .systemFont(ofSize: 14), textColor: .gray, textAlignment: .center)
    private lazy var startSliderValueLabel = UILabel(text: "0:00", font: .systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    private lazy var endSliderValueLabel = UILabel(text: "0:00", font: .systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.thumbTintColor = .systemBlue
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .lightBlueColor
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchUp(_:)), for: .touchDown)
        return slider
    }()

    private lazy var buttonsStackView: UIStackView = {
        let sv = UIStackView(axis: .horizontal, spacing: 0)
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private lazy var reverseView = CornerRadiusUIView(background: .buttonsViewColor.withAlphaComponent(0), rounding: 30)
    private lazy var playPauseView = CornerRadiusUIView(background: .buttonsViewColor.withAlphaComponent(0), rounding: 30)
    private lazy var forwardView = CornerRadiusUIView(background: .buttonsViewColor.withAlphaComponent(0), rounding: 30)
    
    private lazy var reverseButton: NowPlayingButtons = {
        let button = NowPlayingButtons(pointSize: 30, image: UIImage(systemName: "backward.fill"))
        button.addTarget(self, action: #selector(touchedUpIndide(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchedDown(_:)), for: .touchDown)
        return button
    }()
    
    private lazy var playPauseButton: NowPlayingButtons = {
        let button = NowPlayingButtons(pointSize: 40, image: UIImage(systemName: "pause.fill"))
        button.addTarget(self, action: #selector(touchedUpIndide(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchedDown(_:)), for: .touchDown)
        return button
    }()
    
    private lazy var forwardButton: NowPlayingButtons = {
        let button = NowPlayingButtons(pointSize: 30, image: UIImage(systemName: "forward.fill"))
        button.addTarget(self, action: #selector(touchedUpIndide(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchedDown(_:)), for: .touchDown)
        return button
    }()
    
    init(nowPlayingModel: NowPlayingViewModel, tracks: [String], currentTrack: Int) {
        self.nowPlayingViewModel = nowPlayingModel
        self.musicPlayerViewModel = MusicPlayerViewModel(tracks: tracks, currentIndex: currentTrack)
        self.currentTrack = currentTrack
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setNavigationBarWithBackButton(title: "Now playing")
        setupNavigationBarWithBookmark()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayerViewModel.delegate = self
        configureVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupPlayer()
        configurePlayer()
    }
    
    @IBAction private func sliderTouchUp(_ sender: UISlider) {
        isSliderBeingDragged = false
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        isSliderBeingDragged = true
        let value = musicPlayerViewModel.normalizeMinuteSecondFormat(sender.value)
        startSliderValueLabel.text = String(format: "%.2f", value).replacingOccurrences(of: ".", with: ":")
        musicPlayerViewModel.updateCurrentTime(sliderValue: Double(value))
    }

    private func setupPlayer() {
        musicPlayerViewModel.setupPlayer()
        musicPlayerViewModel.playMusic()
    }
    
    private func configureVC() {
        Task {
            let model = nowPlayingViewModel.podcastImage[currentTrack]
            let image = try await nowPlayingViewModel.networkService.loadImageTask(from: model)
            musicImage.image = image
        }
        
        musicLabel.text = nowPlayingViewModel.podcastTitle[currentTrack]
        creatorLabel.text = nowPlayingViewModel.podcastCreator[currentTrack]
    }
    
    private func configurePlayer() {
        let duration = musicPlayerViewModel.totalTime
        endSliderValueLabel.text = String(format: "%.2f", duration).replacingOccurrences(of: ".", with: ":")
        musicSlider.maximumValue = Float(duration)
    }
    
    private func setupNavigationBarWithBookmark() {
        let button = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(bookmarkButtonPressed(_:)))
        nowPlayingViewModel.realmService.checkPodcastInRealm(id: nowPlayingViewModel.podcastId[currentTrack]) {
            self.navigationItem.rightBarButtonItem = button
        } failureCompletion: {
            self.navigationItem.rightBarButtonItem = button
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
        }
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
    
    @IBAction private func bookmarkButtonPressed(_ sender: UIBarButtonItem) {
        switch sender.image {
        case UIImage(systemName: "bookmark"):
            sender.image = UIImage(systemName: "bookmark.fill")
            nowPlayingViewModel.realmService.savePodcastToRealm(id: nowPlayingViewModel.podcastId[currentTrack], podcastURL: nowPlayingViewModel.podcastMusic[currentTrack], imageURL: nowPlayingViewModel.podcastImage[currentTrack], title: nowPlayingViewModel.podcastTitle[currentTrack], creator: nowPlayingViewModel.podcastCreator[currentTrack])
        case UIImage(systemName: "bookmark.fill"):
            sender.image = UIImage(systemName: "bookmark")
            nowPlayingViewModel.realmService.deletePodcastFromRealm(id: nowPlayingViewModel.podcastId[currentTrack])
        default: break
        }
    }
    
    @IBAction private func playPauseButtonPressed(_ sender: UIButton) {
        isPlaying.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        if isPlaying {
            musicPlayerViewModel.playMusic()
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: []) {
                sender.setImage(UIImage(systemName: "pause.fill")?.withConfiguration(config), for: .normal)
                self.musicImage.transform = CGAffineTransform.identity
            }
        } else {
            musicPlayerViewModel.pauseMusic()
            UIView.animate(withDuration: 0.5) {
                sender.setImage(UIImage(systemName: "play.fill")?.withConfiguration(config), for: .normal)
                self.musicImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction public func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView
        switch sender {
        case reverseButton:
            buttonBackground = reverseView
        case playPauseButton:
            buttonBackground = playPauseView
        case forwardButton:
            buttonBackground = forwardView
            
        default: return
        }
        UIView.animate(withDuration: 0.5) {
            buttonBackground.backgroundColor = buttonBackground.backgroundColor?.withAlphaComponent(0.3)
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }

    @IBAction public func touchedUpIndide(_ sender: UIButton) {
        let buttonBackground: UIView
        switch sender {
        case reverseButton:
            buttonBackground = reverseView
            if currentTrack < 0 {
                currentTrack = nowPlayingViewModel.podcastMusic.count
                configureVC()
                configurePlayer()
            } else {
                currentTrack -= 1
                configureVC()
                configurePlayer()
            }
            musicPlayerViewModel.playPreviousTrack()
        case playPauseButton:
            buttonBackground = playPauseView
        case forwardButton:
            buttonBackground = forwardView
            if currentTrack > nowPlayingViewModel.podcastMusic.count {
                currentTrack = 0
                configureVC()
                configurePlayer()
            } else {
                currentTrack += 1
                configureVC()
                configurePlayer()
            }
            
            musicPlayerViewModel.playNextTrack()
        default: return
        }
        UIView.animate(withDuration: 0.5, animations: {
            buttonBackground.backgroundColor = buttonBackground.backgroundColor?.withAlphaComponent(0)
            sender.transform = CGAffineTransform.identity
        })
    }

    private func setupUI() {
        view.addSubviews(musicImage, musicLabel, creatorLabel, startSliderValueLabel, endSliderValueLabel, musicSlider, buttonsStackView)

        buttonsStackView.addArrangedSubviews(reverseView, playPauseView, forwardView)
        
        reverseView.addSubviews(reverseButton)
        playPauseView.addSubviews(playPauseButton)
        forwardView.addSubviews(forwardButton)
        
        NSLayoutConstraint.activate([
            musicImage.heightAnchor.constraint(equalToConstant: 350),
            musicImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            musicImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            musicImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            musicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicLabel.topAnchor.constraint(equalTo: musicImage.bottomAnchor, constant: 30),
            
            creatorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creatorLabel.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 10),
            
            startSliderValueLabel.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 28),
            startSliderValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            endSliderValueLabel.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 28),
            endSliderValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            musicSlider.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 20),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            buttonsStackView.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 30),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
            
            reverseView.heightAnchor.constraint(equalToConstant: 60),
            reverseView.widthAnchor.constraint(equalToConstant: 60),
            playPauseView.heightAnchor.constraint(equalToConstant: 60),
            playPauseView.widthAnchor.constraint(equalToConstant: 60),
            forwardView.heightAnchor.constraint(equalToConstant: 60),
            forwardView.widthAnchor.constraint(equalToConstant: 60),
            
            reverseButton.centerYAnchor.constraint(equalTo: reverseView.centerYAnchor),
            reverseButton.centerXAnchor.constraint(equalTo: reverseView.centerXAnchor),
            
            playPauseButton.centerYAnchor.constraint(equalTo: playPauseView.centerYAnchor),
            playPauseButton.centerXAnchor.constraint(equalTo: playPauseView.centerXAnchor),
            
            forwardButton.centerYAnchor.constraint(equalTo: forwardView.centerYAnchor),
            forwardButton.centerXAnchor.constraint(equalTo: forwardView.centerXAnchor)
        ])
    }
}

extension NowPlayingViewController: CurrentTimeValueChangedDelegate {
    func changeValue(time: Double) {
        if !musicSlider.isTracking && !musicPlayerViewModel.isPaused {
            let currentTime = String(format: "%.2f", time).replacingOccurrences(of: ".", with: ":")
            startSliderValueLabel.text = currentTime
            musicSlider.setValue(Float(time), animated: true)
        }
    }
}
