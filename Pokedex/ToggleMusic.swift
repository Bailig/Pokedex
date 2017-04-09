//
//  ToggleMusic.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-08.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//
import UIKit
import AVFoundation

struct ToggleMusic {
    private init () { }
    static func toggle(musicPlayer: AVAudioPlayer, musicBtn: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            musicBtn.alpha = 0.3
        } else {
            musicPlayer.play()
            musicBtn.alpha = 1
        }
    }
}
