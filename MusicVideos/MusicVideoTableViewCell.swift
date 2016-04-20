//
//  MusicVideoTableViewCell.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/20/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!

    func updateCell() {
        
        musicTitle.text = video!.vName
        rank.text = "\(video!.vRank)"
        musicImage.image = UIImage(named: "imageNotAvailable")
        
    }

}
