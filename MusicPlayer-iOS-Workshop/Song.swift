//
//  Song.swift
//  MusicPlayer-iOS-Workshop
//
//  Created by Admin on 2016-09-09.
//  Copyright © 2016 LHL. All rights reserved.
//

import UIKit

class Song: NSObject {
    
    let artist:String
    let title:String
    let image:UIImage
    let musicFilePath:URL
    
    init(artist:String, title:String, image:UIImage, musicFilePath:URL){
        self.artist = artist
        self.title = title
        self.image = image
        self.musicFilePath = musicFilePath
    }
    
}
