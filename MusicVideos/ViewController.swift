//
//  ViewController.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/18/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos = [Videos]()
        
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
    
    // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
    
    }

    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            print("\(index). Name = \(item.vName)")
            print("\(index). Name = \(item.vImageUrl)")
            print("\(index). Name = \(item.vVideoUrl)")
            print("\(index). Name = \(item.vRights)")
            print("\(index). Name = \(item.vPrice)")
            print("\(index). Name = \(item.vArtist)")
            print("\(index). Name = \(item.vGenre)")
            print("\(index). Name = \(item.vLinkToiTunes)")
            print("\(index). Name = \(item.vReleaseDte)")
            print("\(index). Name = \(item.vImid)")
           
        }
        
        tableView.reloadData()
    
    }
    
    func reachabilityStatusChanged () {
        
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
                        displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
                        displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
                        displayLabel.text = "Reachable with Cellular"
        default: return
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = "\(video.vRank)"
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
  
}