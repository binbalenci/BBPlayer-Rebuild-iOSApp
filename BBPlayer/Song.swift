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
    private var _songImage: String!
    
    var songTitle: String {
        get {
            return _songTitle
        } set(newVal) {
            _songTitle = newVal
        }
    }
    
    var songArtist: String {
        get {
            return _songArtist
        } set (newVal) {
            _songArtist = newVal
        }
    }
    
    var songImage: String {
        get {
            return _songImage
        } set {
            _songImage = newValue
        }
    }
    
    init() {
        self._songTitle = "No Title"
        self._songArtist = "No Artist"
        self._songImage = "No Image"
    }
    
    init(songTitle: String, songArtist: String, songImage: String) {
        self._songTitle = songTitle
        self._songArtist = songArtist
        self._songImage = songImage
    }
}
