//
//  MusicVideoTVC.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/20/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    var video: Videos!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = self
       // tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
       // runAPI()
        
        
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
        case NOACCESS: //view.backgroundColor = UIColor.redColor()
        
            dispatch_async(dispatch_get_main_queue()) {
        
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action -> () in
                print("Cancel")
            }
        
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                action -> () in
                print("Delete")
            }
            
            let okAction = UIAlertAction(title: "OK", style: .Default) {
                action -> () in
                print("OK")
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
        
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do not refresh API")
            } else {
                runAPI()
            }
        }
        
    }
    
    func runAPI() {
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

               
        cell.video = videos[indexPath.row]
        
        
        return cell

    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        video = videos[indexPath.row]
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if let detailVC = segue.destinationViewController as? MusicVideoDetailVC {
         
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                detailVC.video = videos[indexPath.row]
            }
        }
    }
    

}
