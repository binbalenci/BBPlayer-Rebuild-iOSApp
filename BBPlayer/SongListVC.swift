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
let coverArray = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: "cover")!
let songArray = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "song")!

class SongListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var songTitleList = [String]()
    var songArtistList = [String]()
    var randomNumberArray = [Int]()
    
    /*
     Function getTitleAndArtist()
     Run through each URL in songArray and append the
     artist and title to the array, if artist or
     title does not present, it will append "No
     Artist Found"
     */
    func getTitleAndArtist() {
        for song in songArray {
            var hasArtist = false
            var hasTitle = false
            let playerItem = AVPlayerItem(url: song)
            let metadataList = playerItem.asset.commonMetadata
            for item in metadataList {
                if item.commonKey != nil && item.value != nil {
                    if item.commonKey == "title" {
                        songTitleList.append(item.stringValue!)
                        hasTitle = true
                    }
                    
                    if item.commonKey == "artist" {
                        songArtistList.append(item.stringValue!)
                        hasArtist = true
                    }
                }
            }
            
            if hasArtist == false {
                songArtistList.append("No Artist Found")
            }
            
            if hasTitle == false {
                songTitleList.append("No Title Found")
            }
            
        }
    }
    
    /*
     Function generateRandomNumber()
     Generate a random number for a random cover image
     */
    func generateRandomNumber() {
        let coverArrayCount = UInt32(coverArray.count)
        
        for _ in 0...songArray.count {
            let randomNumber = Int(arc4random_uniform(coverArrayCount)) + 1
            randomNumberArray.append(randomNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getTitleAndArtist()
        generateRandomNumber()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! MyCustomTableViewCell
        
        //Suggest that the song can be clickable
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let row = indexPath.row
        
        let randomNumber = randomNumberArray[row]
        
        cell.songTitle.text = songTitleList[row]
        
        cell.songArtist.text = songArtistList[row]
        
        cell.songImage.image = UIImage(named: "cover/cover\(randomNumber).jpg")
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegue(withIdentifier: "showMediaPlayer", sender: tableView)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMediaPlayer" {
            
            let VC = segue.destination as! MediaPlayerVC
            
            let indexPath: IndexPath = tableView.indexPathForSelectedRow!
            
            /*
             parsing necessary variable and data for
             ther other ViewController
             */
            VC.audioURL = songArray[indexPath.row]
            VC.parsedSongTitle = songTitleList[indexPath.row]
            VC.parsedSongArtist = songArtistList[indexPath.row]
            VC.parsedRandomNumber = randomNumberArray[indexPath.row]
            
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //Reload Data when rotating
        self.tableView.reloadData()
    }
}

/*
 class MyCustomTableViewCell
 A subclass to hold the outlet of the cell
 */
class MyCustomTableViewCell: UITableViewCell {
    
    @IBOutlet var songTitle: UILabel!
    
    @IBOutlet var songArtist: UILabel!
    
    @IBOutlet var songImage: UIImageView!
    
}
