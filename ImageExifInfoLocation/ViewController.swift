//
//  ViewController.swift
//  ImageExifInfoLocation
//
//  Created by King on 9/3/2016.
//  Copyright © 2016 YING YIK KING. All rights reserved.
//

import UIKit
import Photos //This for PHAsset...


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnFromFile: UIButton!
    @IBOutlet weak var btnFromPhoto: UIButton!
    @IBOutlet weak var txtInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickImageFromPhtos(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.delegate = self
        self.presentViewController(picker, animated: true) { () -> Void in
            
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let url = info["UIImagePickerControllerReferenceURL"] as! NSURL
        if let asset = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil).lastObject as? PHAsset{
            txtInfo.text = "\(asset.location)"
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnFromFilePressed(sender: AnyObject) {
        //Load Default Image From Bundle
        
        if let imageURL = NSBundle.mainBundle().URLForResource("20160228_130116", withExtension: "jpg"){
            let opts = [kCGImageSourceShouldCache as String: kCFBooleanFalse]
            if let imageSource = CGImageSourceCreateWithURL(imageURL, opts) {
                
                if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, opts) {
                    let gps = CFDictionaryGetValue(imageProperties, unsafeAddressOf(kCGImagePropertyGPSDictionary))
                    if gps != nil {
                        let gpsDict = unsafeBitCast(gps, CFDictionaryRef.self)
                        let gpsLat = CFDictionaryGetValue(gpsDict, unsafeAddressOf(kCGImagePropertyGPSLatitude))
                        let gpsLong = CFDictionaryGetValue(gpsDict, unsafeAddressOf(kCGImagePropertyGPSLongitude))
                        let gpsLatStr = unsafeBitCast(gpsLat, CFString.self)
                        let gpsLongStr = unsafeBitCast(gpsLong, CFString.self)
                        txtInfo.text = "Lat:\(gpsLatStr) / Lon:\(gpsLongStr)"
                    }
                }
            }
        }
    }
    
    @IBAction func btnFromPhotoPressed(sender: AnyObject) {
        self.pickImageFromPhtos()
    }

}

