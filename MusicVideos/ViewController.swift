//
//  ViewController.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/18/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    
    }

    func didLoadData(result: String) {
        
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
 

}

