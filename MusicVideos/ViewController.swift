//
//  ViewController.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/18/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    
    }

    func didLoadData(videos: [Videos]) {
        
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            print("\(index). Name = \(item.vName)")
           
        }
    
    }
    
  
}