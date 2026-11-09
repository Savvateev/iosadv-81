
import Foundation
import AVFoundation
import Combine

final class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published private(set) var isPlaying = false
    @Published private(set) var hasTrack = false

    private var player: AVAudioPlayer?

    /// Загружает файл из бандла по имени без расширения (mp3, m4a или wav)
    func load(named name: String) {
        stop()
        player = nil
        hasTrack = false

        guard let url = Self.url(for: name) else { return }

        do {
            #if os(iOS)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            #endif

            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.delegate = self
            newPlayer.prepareToPlay()
            player = newPlayer
            hasTrack = true
        } catch {
            print("Audio error: \(error)")
        }
    }

    func toggle() {
        guard let player else { return }
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }

    // Когда трек доиграл, кнопка возвращается в состояние «Play»
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        player.currentTime = 0
    }

    private static func url(for name: String) -> URL? {
        for ext in ["mp3", "m4a", "wav"] {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                return url
            }
        }
        return nil
    }
}
