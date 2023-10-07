import AVFoundation

protocol CurrentTimeValueChangedDelegate: AnyObject {
    func changeValue(time: Double)
}

// playerQueue
class MusicPlayerViewModel {
    private var player: AVPlayer?
    weak var delegate: CurrentTimeValueChangedDelegate?
    var tracks: [String] = []
    
    var currentIndex = 0
    var isPaused = false
    var totalTime: Double = 0
    var currentTime: Double = 0.0 {
        didSet {
            delegate?.changeValue(time: currentTime)
        }
    }
    
    init(tracks: [String], currentIndex: Int) {
        self.tracks = tracks
        self.currentIndex = currentIndex
    }
    
    
    func playNextTrack() {
        currentIndex += 1
        if currentIndex >= tracks.count {
            currentIndex = 0
        }
        setupPlayer()
        playMusic()
    }
    
    
    func playPreviousTrack() {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = tracks.count - 1
        }
        setupPlayer()
        playMusic()
    }
    
    
    func setupPlayer() {
        guard let url = URL(string: tracks[currentIndex]) else { return }
        print(url)
            
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
            
        if let duration = player?.currentItem?.asset.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            self.currentTime = converteToMinute(from: totalSeconds)
            self.totalTime = converteToMinute(from: totalSeconds)
        }
    }
    
    func converteToMinute(from second: Double) -> Double {
        let minutes = Int(second / 60)
        let seconds = Int(second.truncatingRemainder(dividingBy: 60))
        return Double(minutes) + Double(seconds) / 100.0
    }
    
    
    
    func addObserver() {
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main, using: { [weak self] time in
            DispatchQueue.main.async {
                let timeInSecounds = CMTimeGetSeconds(time)
                self?.currentTime = self?.converteToMinute(from: timeInSecounds) ?? 0
            }
        })
    }
    
    func playMusic() {
        player?.play()
        addObserver()
    }
    
    func pauseMusic() {
        player?.pause()
        if let time = player?.currentTime() {
            currentTime = converteToMinute(from: CMTimeGetSeconds(time))
        }
    }
    
    func updateCurrentTime(sliderValue: Double) {
        let minutes = Int(sliderValue)
        let seconds = Int((sliderValue - Double(minutes)) * 100)
        let totalSeconds = minutes * 60 + seconds
        
        let time = CMTime(seconds: Double(totalSeconds), preferredTimescale: 1)
        
        player?.seek(to: time, completionHandler: { [weak self] _ in
            DispatchQueue.main.async {
                
                self?.currentTime = sliderValue
            }
        })
    }

    
    func normalizeMinuteSecondFormat(_ minuteWithSeconds: Float) -> Float {
        let minutePart = Int(minuteWithSeconds)
        var secondPart = (minuteWithSeconds - Float(minutePart)) * 100.0
        
        let additionalMinutes = Int(secondPart) / 60
        secondPart = Float(Int(secondPart) % 60)
        
        let normalizedMinutes = Float(minutePart + additionalMinutes)
        return normalizedMinutes + secondPart / 100.0
    }
}
