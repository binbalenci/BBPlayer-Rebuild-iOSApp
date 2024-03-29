//
//  MediaAppViewController.swift
//  Media App
//
//  Created by Nam Meo on 26/04/16.
//  Copyright © 2016 Nam Meo. All rights reserved.
//

import UIKit
import AVFoundation

class MediaPlayerVC: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var audioURL: URL?
    var parsedSongTitle: String?
    var parsedSongArtist: String?
    var parsedRandomNumber: Int?
    var playing = true

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var songDescription: UILabel!
    @IBOutlet weak var sliderValue: UISlider!
    
    //Change the volume according the the slider value
    @IBAction func sliderMoved(_ sender: AnyObject) {
        player.volume = sliderValue.value
    }
    
    //Restart the whole song
    @IBAction func restart(_ sender: AnyObject) {
        player.currentTime = 0
    }
    
    /*
     Function playPauseToggle()
     Change the implementation and icon of the button according
     the current state of the song
     */
    @IBAction func playPauseToggle(_ sender: UIBarButtonItem) {
        
        var toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(self.playPauseToggle(_:)))
        
        if playing {
            player.pause()
            playing = false
        } else {
            player.play()
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(self.playPauseToggle(_:)))
            playing = true
        }
        
        
        var items = toolBar.items!
        items[2] = toggleBtn
        toolBar.setItems(items, animated: true)
        
    }
    
    /*
     Function songInfo()
     Set song info (title, artist, description, cover Image) 
     based on the parsed data from the navigation controller
    */
    func songInfo() {
        songTitle.text = parsedSongTitle
        songArtist.text = parsedSongArtist
        //songDescription.text = Lorem.sentences(3)
        coverImage.image = UIImage(named: "cover/cover\(parsedRandomNumber!).jpg")
        //songDescription.text = Lorem.sentences(3)

    }
    
    /*
     function initateAudio()
     Define the player according to the parsed URL
     */
    func initiateAudio(){
        let audioAbsoluteURL = audioURL?.absoluteURL
        
        do {
            player = try AVAudioPlayer(contentsOf: audioAbsoluteURL!, fileTypeHint: nil)
            
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initiateAudio()
        
        songInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Make the song autoplay when clicked from the other view
    override func viewDidAppear(_ animated: Bool) {
        player.play()
    }

}
