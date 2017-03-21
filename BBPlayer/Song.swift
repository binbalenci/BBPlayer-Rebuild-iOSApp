//
//  Song.swift
//  BBPlayer
//
//  Created by Binh Bui on 13/03/2017.
//  Copyright © 2017 Binh Bui. All rights reserved.
//

import Foundation

class Song {
    private var _songTitle: String!
    private var _songArtist: String!
    
    var songTitle: String {
        return _songTitle
    }
    
    var songArtist: String {
        return _songArtist
    }
    
    init(songTitle: String, songArtist: String) {
        self._songTitle = songTitle
        self._songArtist = songArtist
    }
}
