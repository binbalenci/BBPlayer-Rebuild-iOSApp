//
//  ViewController.swift
//  BBPlayer
//
//  Created by Binh Bui on 13/03/2017.
//  Copyright © 2017 Binh Bui. All rights reserved.
//

import UIKit
import AVFoundation

/*
 Global Variable: coverArray and songArray
 Make an array of URL for the cover images and songs
 */
let coverUrlArray = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: "cover")!
let songUrlArray = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "song")!

class SongListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var songTitleList = [String]()
    var songArtistList = [String]()
    var randomNumberArray = [Int]()
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        appendSongData()
     }
    
    // MARK: Supporting functions
    /*
     Run through each URL in songArray and append the artist and title to the array, 
     if artist or title does not present, it will append "No Artist Found"
     */
    func appendSongData() {
        for song in songUrlArray {
            var tempTitle = ""
            var tempArtist = ""
            var tempImage = ""
            
            let playerItem = AVPlayerItem(url: song)
            let metadataList = playerItem.asset.commonMetadata
            for item in metadataList {
                if item.commonKey != nil && item.value != nil {
                    if item.commonKey == "title" {
                        tempTitle = item.stringValue!
                    }
                    
                    if item.commonKey == "artist" {
                        tempArtist = item.stringValue!
                    }
                }
             
                let coverArrayCount = UInt32(coverUrlArray.count)
                
                for _ in 0...songUrlArray.count {
                    let randomNumber = Int(arc4random_uniform(coverArrayCount)) + 1
                    tempImage = "cover/cover\(randomNumber).jpg"
                }
                
                let song = Song(songTitle: tempTitle, songArtist: tempArtist, songImage: tempImage)
                songs.append(song)
            }
            
        }
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell {
            
            //Suggest that the song can be clickable
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            let currentSong = songs[indexPath.row]
            
            cell.updateUI(song: currentSong)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let song = songs[indexPath.row]
        
        self.performSegue(withIdentifier: "showMediaPlayer", sender: song)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MediaPlayerVC {
            
            if let song = sender as? Song {
                destination.song = song
            }
            
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //Reload Data when rotating
        self.tableView.reloadData()
    }
    
}
