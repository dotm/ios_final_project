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
    static func playSfx(soundEffectUrl:URL, volume: Float, completion: (()->())?) {
        player.playSfx(soundEffectUrl: soundEffectUrl, volume: volume, completion: completion)
    }
    static func playSfx(soundEffectUrl:URL, volume: Float) {
        player.playSfx(soundEffectUrl: soundEffectUrl, volume: volume, completion: nil)
    }
}
fileprivate let fade_outBgm = 0.3
fileprivate class SoundEffectPlayer: NSObject {
    var soundEffectPlayer: AVAudioPlayer?
    var completion: (()->())?
    
    func playSfx(soundEffectUrl:URL, completion: (()->())?) {
        self.completion = completion
        BackgroundMusicPlayer.setVolume(0.2, duration: fade_outBgm)
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
    func playSfx(soundEffectUrl:URL,volume:Float, completion: (()->())?) {
        self.completion = completion
        BackgroundMusicPlayer.setVolume(volume, duration: fade_outBgm)
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
