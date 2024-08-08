//
//  RadioPlayer.swift
//  RadioApp
//
//  Created by Руслан on 02.08.2024.
//

import Foundation
import AVFoundation

class RadioPlayer {
    enum PlayerType {
        case musicResults
        case musicSearch
    }

    static let shared = RadioPlayer()

    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentURL: String?
    private var currentPlayerType: PlayerType = .musicResults
    private var musicResults: [StationModel] = []

    // Свойство громкости для AVPlayer
    private var volume: Float = 1.0 {
        didSet {
            player?.volume = volume
        }
    }

    func loadPlayer(from episode: StationModel) {
        guard let musicURL = URL(string: episode.streamUrl) else {
            print("Invalid music URL")
            return
        }

        currentPlayerType = .musicResults

        playerItem = AVPlayerItem(url: musicURL)
        player = AVPlayer(playerItem: playerItem)
        player?.volume = volume  // Установка громкости при загрузке
        player?.play()
        currentURL = episode.streamUrl
    }

    func playMusicWithURL(_ episode: StationModel) {
        if isPlayingMusic(from: episode.streamUrl) {
            pauseMusic()
        } else {
            loadPlayer(from: episode)
            currentURL = episode.streamUrl
        }
    }

    func playMusic() {
        player?.play()
    }

    func pauseMusic() {
        player?.pause()
    }

    func stopMusic() {
        player?.pause()
        player = nil
        currentURL = nil
    }

    func isPlayingMusic(from url: String) -> Bool {
        return currentURL == url && player?.rate != 0 && player?.error == nil
    }

    func isPlayerPerforming() -> Bool {
        return player?.timeControlStatus == .playing ? true : false
    }

    func setVolume(_ volume: Float) {
        self.volume = max(0.0, min(volume, 1.0)) // Ограничение от 0.0 до 1.0
    }
}
