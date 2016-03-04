//
//  ImageViewController.swift
//  ImagePersistencePractice
//
//  Created by Mehdi Salemi on 3/4/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import UIKit
import Foundation

class ImageViewController: UIViewController {


    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBAction func photoPressed(sender: UIButton) {
        
        var url : NSURL!
        switch(sender.titleLabel!.text!) {
        case "Shark":
            url = NSURL(string: BigImages.shark.rawValue)
        case "Whale":
            url = NSURL(string: BigImages.whale.rawValue)
        case "Sea Lion":
            url = NSURL(string: BigImages.seaLion.rawValue)
        default:
            print("No URL")
            return
        }
        self.statusLabel.text = "Downloading Image .... "
        download(url)
        saveLastChosen(sender.titleLabel!.text!)
    }
    
    func download(url : NSURL){
        
        let background = dispatch_queue_create("Download", nil)
        
        dispatch_async(background) {
            let imageData = NSData(contentsOfURL: url)
            let image = UIImage(data : imageData!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.photoView.image = image!
                self.statusLabel.text = "Finished Downloading!"
            })
        }
    }
    
    func saveLastChosen(image : String){
        NSUserDefaults.standardUserDefaults().setObject(image, forKey: "lastChosen")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(true)
        statusLabel.text = "Welcome!"
        if NSUserDefaults.standardUserDefaults().objectForKey("lastChosen") != nil {
            print("Last Chosen Image was \(NSUserDefaults.standardUserDefaults().objectForKey("lastChosen")!)")
        }
    }
}

