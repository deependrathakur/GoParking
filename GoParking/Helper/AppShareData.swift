//
//  AppShareData.swift
//  MualabBusiness
//
//  Created by Mac on 27/12/2017 .
//  Copyright © 2017 Mindiii. All rights reserved.
//

import Foundation
import UIKit
import AVKit

let objAppShareData = AppShareData.sharedObject()

class AppShareData {
    //MARK: - Shared object
    private static var sharedManager: AppShareData = {
        let manager = AppShareData()
        return manager
    }()
    // MARK: - Accessors
    class func sharedObject() -> AppShareData {
        return sharedManager
    }
    
}

//MARK: - Class functions
extension AppShareData{
    func shakeTextField(_ txtField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = CGPoint(x:txtField.center.x - 7,y:txtField.center.y)
        animation.toValue = CGPoint(x:txtField.center.x + 7, y:txtField.center.y)
        txtField.layer.add(animation,forKey: "position")
    }
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    //MARK: - Image thumb with size
    func generateImage(fromURL URL: URL, withSize size:CGSize) -> UIImage {
        let asset = AVAsset.init(url: URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        assetImageGenerator.appliesPreferredTrackTransform=true;
        
        let maxSize = size
        assetImageGenerator.maximumSize = maxSize
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
            
        } catch {
            //print(error)
        }
        return UIImage()
    }
    
    func alertController(objVievController:UIViewController,message:String){
        let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        objVievController.present(alertController, animated: true, completion: nil)
    }
}

