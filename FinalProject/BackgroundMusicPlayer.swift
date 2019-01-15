//
//  BackgroundMusicPlayer.swift
//  FinalProject
//
//  Created by Yoshua Elmaryono on 06/01/19.
//  Copyright © 2019 Kelompok 3. All rights reserved.
//

import Foundation
import AVFoundation

enum BackgroundMusicPlayer {
    private static var activePlayer: AVAudioPlayer?
    private static var mainMenu_audioPlayer: AVAudioPlayer!
    private static var battleScene_audioPlayer: AVAudioPlayer!
    
    static func initialize(){
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            let infiniteNumber_ofLoops = -1
            let SONG_FILE_TYPE = "mp3"
            let BGM_DIRECTORY = "bgm"
            
            let mainMenu_songURL = Bundle.main.url(forResource: "main_menu_song", withExtension: SONG_FILE_TYPE, subdirectory: BGM_DIRECTORY)!
            mainMenu_audioPlayer = try AVAudioPlayer(contentsOf: mainMenu_songURL, fileTypeHint: SONG_FILE_TYPE)
            mainMenu_audioPlayer.numberOfLoops = infiniteNumber_ofLoops
            
            let battleScene_songURL = Bundle.main.url(forResource: "battle_scene_song", withExtension: SONG_FILE_TYPE, subdirectory: BGM_DIRECTORY)!
            battleScene_audioPlayer = try AVAudioPlayer(contentsOf: battleScene_songURL, fileTypeHint: SONG_FILE_TYPE)
            battleScene_audioPlayer.numberOfLoops = infiniteNumber_ofLoops
            
        } catch {
            print(error.localizedDescription)
        }
    }
    static func playMainMenuSong(){
        fadeOutCurrentSong_andStart(audioPlayer: mainMenu_audioPlayer)
    }
    static func playBattleSceneSong(){
        fadeOutCurrentSong_andStart(audioPlayer: battleScene_audioPlayer)
    }
    private static func fadeOutCurrentSong_andStart(audioPlayer: AVAudioPlayer){
        let fade_inSeconds = 5.0
        if let activePlayer = activePlayer {
            activePlayer.setVolume(0, fadeDuration: fade_inSeconds)
            Timer.scheduledTimer(withTimeInterval: fade_inSeconds, repeats: false) { (_) in
                activePlayer.stop()
                
                audioPlayer.volume = 1.0
                audioPlayer.currentTime = 0
                audioPlayer.play()
                
                self.activePlayer = audioPlayer
            }
        }else{
            audioPlayer.volume = 1.0
            audioPlayer.currentTime = 0
            audioPlayer.play()
            
            activePlayer = audioPlayer
        }
    }
}
