//
//  songCell.swift
//  BBPlayer
//
//  Created by Binh Bui on 21/03/2017.
//  Copyright © 2017 Binh Bui. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var songImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI(song: Song) {
        songTitle.text = song.songTitle
        songArtist.text = song.songArtist
        songImage.image = UIImage(named: song.songImage)
    }
    
}
