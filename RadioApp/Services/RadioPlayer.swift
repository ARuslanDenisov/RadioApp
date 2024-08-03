//
//  RadioPlayer.swift
//  RadioApp
//
//  Created by Руслан on 02.08.2024.
//

import Foundation
import AVFoundation
import MediaPlayer
import AVKit

class RadioPlayer: ObservableObject {
    static let instance = RadioPlayer() ; private init() { }
    var player = AVPlayer()
    
  
    
    @Published var isPlaying = false
    @Published var currentRadio: URL = URL(string: "https://0n-jazz.radionetz.de/0n-jazz.mp3")!
    
    func initPlayer() {
        let playerItem = AVPlayerItem(url: currentRadio)
        player = AVPlayer(playerItem: playerItem)
    }
    func stop(){
        isPlaying = false
        player.pause()
    }
    func play(_ url: URL) {
        currentRadio = url
        player.volume = 0.1
        player.play()
        isPlaying = true
    }
}
