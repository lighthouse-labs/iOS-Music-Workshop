//
//  MediaPlayer.swift
//  MusicPlayer-iOS-Workshop
//
//  Created by Admin on 2016-09-09.
//  Copyright © 2016 LHL. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol MediaPlayerProtocol{
    func displaySong(song: Song)
}

class MediaPlayer: NSObject {
    
    var avPlayer = AVAudioPlayer()
    var songIndex = 0
    var songs = [Song]()
    
    @IBOutlet weak var delegate:AnyObject?
    
    func setup() {
        
        let song1 = Song(artist: "Ben Pearce", title: "What I Might Do", image: UIImage(named: "ben-pearce")!, musicFilePath: NSBundle.mainBundle().URLForResource("Ben Pearce - What I Might Do (Kilter Remix)", withExtension: "mp3")!)
        let song2 = Song(artist: "What So Not", title: "High you are", image: UIImage(named: "what-so-not")!, musicFilePath: NSBundle.mainBundle().URLForResource("What So Not - High you are (Branchez Remix)", withExtension: "mp3")!)
        let song3 = Song(artist: "ASTR", title: "Hold On We're Going Home", image: UIImage(named: "astr")!, musicFilePath: NSBundle.mainBundle().URLForResource("ASTR - Hold On We're Going Home [Free DL]", withExtension: "mp3")!)
        
        songs.appendContentsOf([song1, song2, song3])

    }
    
    @IBAction func playMusic() {
        
        let song = songs[songIndex]
        
        avPlayer = try! AVAudioPlayer(contentsOfURL: song.musicFilePath)
        avPlayer.play()
        
        delegate?.displaySong(song)
    }
    
    @IBAction func playNextSong(){
        songIndex = songIndex + 1
        
        if songIndex >= songs.count {
            songIndex = 0
        }
        
        playMusic()
    }
    
    @IBAction func playPreviousSong(){
        songIndex = songIndex - 1
        
        if songIndex < 0 {
            songIndex = songs.count - 1
        }
        
        playMusic()
    }

}
