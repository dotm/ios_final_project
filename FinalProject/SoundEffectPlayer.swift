//
//  SoundEffectPlayer.swift
//  FinalProject
//
//  Created by Benny Kurniawan on 14/02/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import AVFoundation

enum SFXPlayer {
    private static let player = SoundEffectPlayer()
    static func playSfx(soundEffectUrl:URL) {
        player.playSfx(soundEffectUrl: soundEffectUrl, completion: nil)
    }
    static func playSfx(soundEffectUrl:URL, completion: (()->())?) {
        player.playSfx(soundEffectUrl: soundEffectUrl, completion: completion)
    }
    static func playSfx(soundEffectUrl:URL, fadeOutBgmVolume: Float, completion: (()->())?) {
        player.playSfx(soundEffectUrl: soundEffectUrl, fadeOutBgmVolume: fadeOutBgmVolume, fadeOutBgmDuration:nil, completion: completion)
    }
    static func playSfx(soundEffectUrl:URL, fadeOutBgmVolume: Float) {
        player.playSfx(soundEffectUrl: soundEffectUrl, fadeOutBgmVolume: fadeOutBgmVolume, fadeOutBgmDuration:nil , completion: nil)
    }
    static func playSfx(soundEffectUrl:URL, fadeOutBgmVolume: Float, fadeOutBgmDuration: Double, completion: (()->())?) {
        player.playSfx(soundEffectUrl: soundEffectUrl, fadeOutBgmVolume: fadeOutBgmVolume, fadeOutBgmDuration: fadeOutBgmDuration, completion: completion)
    }
    
}
fileprivate class SoundEffectPlayer: NSObject {
    var fade_outBgm = 0.3
    var soundEffectPlayer: AVAudioPlayer?
    var completion: (()->())?
    
    func playSfx(soundEffectUrl:URL, completion: (()->())?) {
        playSfx(soundEffectUrl: soundEffectUrl, fadeOutBgmVolume: 0.2 ,fadeOutBgmDuration : nil, completion: completion)
    }
    
    func playSfx(soundEffectUrl:URL,fadeOutBgmVolume:Float, fadeOutBgmDuration:Double? ,completion: (()->())?) {
        self.completion = completion
        if let fadeOutBgmDuration = fadeOutBgmDuration {
            fade_outBgm = fadeOutBgmDuration
        }
        
        BackgroundMusicPlayer.setVolume(fadeOutBgmVolume, duration: fade_outBgm)
        Timer.scheduledTimer(withTimeInterval: fade_outBgm, repeats: false) { (_) in
            do {
                self.soundEffectPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl)
                self.soundEffectPlayer?.delegate = self
                self.soundEffectPlayer?.volume = 1.0
                self.soundEffectPlayer?.play()
            } catch {
                print("error : \(error.localizedDescription)")
            }
        }
    }
}
extension SoundEffectPlayer:AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        BackgroundMusicPlayer.setVolume(1, duration: fade_outBgm)
        completion?()
    }
}
