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
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    var video: Videos!
    var securitySwitch: Bool = false
    
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
    
    func touchIdChk() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        let context = LAContext()
        var touchIdError: NSError?
        let reasonString = "Touch-ID authentication is needed to share info on Social Media"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIdError) {
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                    if success {
                        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                            self.shareMedia()
                        }
                    } else {
                        
                        alert.title = "Unsuccessful!"
                        
                        switch LAError(rawValue: policyError!.code)! {
                        
                        case .AppCancel:
                            alert.message = "Authentication was cancelled by application"
                        case .AuthenticationFailed:
                             alert.message = "The user failed to provide valid credentials"
                        case .PasscodeNotSet:
                              alert.message = "Passcode is not set on the device"
                        case .SystemCancel:
                            alert.message = "Authentication was canceled by the system"
                        case .TouchIDLockout:
                             alert.message = "Too many failed attempts"
                        case .UserCancel:
                              alert.message = "Ypu canceled the request"
                        case .UserFallback:
                              alert.message = "Password not accepted, must user Touch-ID"
                        default:
                              alert.message = "Unable to Authenticate!"
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        
                }
                            
            })
        } else {
            alert.title = "Error"
            
            switch LAError(rawValue: touchIdError!.code)! {
                
            case .TouchIDNotEnrolled:
                alert.message = "Touch ID is not enroled"
            case .TouchIDNotAvailable:
                alert.message = "Touch ID is not available on the device"
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
            case .InvalidContext:
                alert.message = "The context is invalid"
            default:
                alert.message = "Local Authentication not available"
            }
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            
            }
            
        }
        
    }

    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSettings")
        
        switch securitySwitch {
            case true:
                touchIdChk()
        default:
                shareMedia()
        }
        
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
