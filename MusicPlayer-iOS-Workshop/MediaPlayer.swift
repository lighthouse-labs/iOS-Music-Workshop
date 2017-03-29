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
    func displaySong(_ song: Song)
    func displayCompletionPercentage(_ percentComplete: Float)
}

class MediaPlayer: NSObject {
    
    var avPlayer = AVPlayer()
    var songIndex = 0
    var songs = [Song]()
    
    @IBOutlet weak var delegate:AnyObject?
    
    func setup() {
        
        let song1 = Song(artist: "Ben Pearce", title: "What I Might Do", image: UIImage(named: "ben-pearce")!, musicFilePath: Bundle.main.url(forResource: "Ben Pearce - What I Might Do (Kilter Remix)", withExtension: "mp3")!)
        let song2 = Song(artist: "What So Not", title: "High you are", image: UIImage(named: "what-so-not")!, musicFilePath: Bundle.main.url(forResource: "What So Not - High you are (Branchez Remix)", withExtension: "mp3")!)
        let song3 = Song(artist: "ASTR", title: "Hold On We're Going Home", image: UIImage(named: "astr")!, musicFilePath: Bundle.main.url(forResource: "ASTR - Hold On We're Going Home [Free DL]", withExtension: "mp3")!)
        
        songs.append(contentsOf: [song1, song2, song3])

    }
    
    @IBAction func playMusic() {
        
        let song = songs[songIndex]
        
        avPlayer = AVPlayer(url: song.musicFilePath as URL)
        avPlayer.play()
        
        delegate?.displaySong(song)
        
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: nil) { (currentTime) in
            
            if let duration = self.avPlayer.currentItem?.duration {
                let durationInSeconds = CMTimeGetSeconds(duration)
                let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
                
                let currentProgress = Float(currentTimeInSeconds/durationInSeconds)
                self.delegate?.displayCompletionPercentage(currentProgress)

            }
        }
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
