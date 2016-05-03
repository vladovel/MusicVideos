//
//  SettingTVC.swift
//  MusicVideos
//
//  Created by Vlado Velkovski on 4/25/16.
//  Copyright © 2016 Vlado Velkovski. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedBackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageQuality: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var numberOfVideosDisplay: UILabel!
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  = "Settings"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSettings")
        
        if NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }
        
        
        
        

    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        
         let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
        
    }
    
    
    @IBAction func touchIdSecurity(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSettings")
        } else {
            defaults.setBool(false, forKey: "SecSettings")
        }
        
    }
    
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQuality.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfVideosDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["vladovel@gmail.com"])
        mailComposeVC.setSubject ("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Vlado, \n\n I Would like to share the followong feedback ... \n", isHTML: false)
        return mailComposeVC
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController , animated: true, completion: nil)
            } else {
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert:", message: "No e-mail Account setup for Phone", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
            case MFMailComposeResultCancelled.rawValue:
                print("Mail canceled")
            case MFMailComposeResultSaved.rawValue:
                print("Mail saved")
            case MFMailComposeResultSaved.rawValue:
                print("Mail Sent")
            case MFMailComposeResultFailed.rawValue:
                print("Mail failed")
            default:
                print("Unknown issue")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }


   

}
