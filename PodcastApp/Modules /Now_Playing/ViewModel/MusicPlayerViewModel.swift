import AVFoundation

protocol CurrentTimeValueChangedDelegate: AnyObject {
    func changeValue(time: Double)
}

class MusicPlayerViewModel {
    var isPaused = false
    weak var delegate: CurrentTimeValueChangedDelegate?
    // playerQueue
    private var player: AVPlayer?
    var totalTime: Double = 0
    var currentTime: Double = 0.0 {
        didSet {
            delegate?.changeValue(time: currentTime)
        }
    }
    
    func setupPlayer(with url: String) {
        guard let url = URL(string: url) else { return }
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
