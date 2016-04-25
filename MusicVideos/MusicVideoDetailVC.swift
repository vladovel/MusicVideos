//
//  MusicVideoDetailVC.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/25/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    var video: Videos!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vName.text = video.vName
        vGenre.text = video.vGenre
        vPrice.text = video.vPrice
        vRights.text = video.vRights
        vImage.image = UIImage(data: video.vImageData!)
        
    }

   
    @IBAction func playVideo(sender: AnyObject) {
        print(video.vName)
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
