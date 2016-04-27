//
//  MusicVideoDetailVC.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/25/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicVideoDetailVC: UIViewController {

    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    var video: Videos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = video.vArtist
 
        vName.text = video.vName
        vGenre.text = video.vGenre
        vPrice.text = video.vPrice
        vRights.text = video.vRights
        if video.vImageData != nil {
            vImage.image = UIImage(data: video.vImageData!)
        } else {
            vImage.image = UIImage(named: "imageNotAvailable")
        }
    }

    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        shareMedia()
        
    }
    
    func shareMedia() {
        
        let activity1 = "Have you had the oportunity to see this Music Video?"
        let activity2 = ("\(video.vName) by \(video.vArtist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = video.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step it Up!)"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        
        activityViewController.completionWithItemsHandler = {
            
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("Email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
   
    @IBAction func playVideo(sender: AnyObject) {
        
        let url = NSURL(string: video.vVideoUrl)!
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
