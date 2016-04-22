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
        
        if video!.vImageData != nil {
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            getVideoImage(video!, imageView: musicImage)
        }
        
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView) {
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
    
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
    
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    
    }

}
