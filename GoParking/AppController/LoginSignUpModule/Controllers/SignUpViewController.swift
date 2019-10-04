//
//  SignUpViewController.swift
//  GoParking
//
//  Created by MAC HD on 30/08/19.
//  Copyright © 2019 MAC HD. All rights reserved.
//

import UIKit
import Photos

class SignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK: - Outlet connection
    @IBOutlet weak var imageUserProfile:UIImageView!
    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var txtFirstName:UITextField!
    @IBOutlet weak var txtLastName:UITextField!
    @IBOutlet weak var txtCountry:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtConfirmPassword:UITextField!
    
    //MARK: - Variable declaration
    var imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
    
    }
}

//MARK: Button method
fileprivate extension SignUpViewController{
    @IBAction func btnImageAction(_ sender:Any){
        self.view.endEditing(true)
        self.selectProfileImage()
    }
    
    @IBAction func btnBackAction(_ sender:Any){
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender:Any){
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUpAction(_ sender:Any){
        txtEmail.text = txtEmail.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtFirstName.text = txtFirstName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtLastName.text = txtLastName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtCountry.text = txtCountry.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtPassword.text = txtPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtConfirmPassword.text = txtConfirmPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
            if txtEmail.text?.count == 0{
                objAppShareData.shakeTextField(txtEmail)
            }else if !objAppShareData.isValidEmail(emailStr:self.txtEmail.text ?? ""){
                objAppShareData.alertController(objVievController: self, message: "Please enter valid email address.")
            }else if txtFirstName.text?.count == 0{
                objAppShareData.shakeTextField(txtFirstName)
            }else if txtLastName.text?.count == 0{
                objAppShareData.shakeTextField(txtLastName)
            }else if txtCountry.text?.count == 0{
                objAppShareData.shakeTextField(txtCountry)
            }else if txtPassword.text?.count == 0{
                objAppShareData.shakeTextField(txtPassword)
            }else if txtPassword.text?.count ?? 0 <= 5{
                objAppShareData.alertController(objVievController: self, message: "Please enter atleast 6 charactor password")
            }else if txtConfirmPassword.text?.count == 0{
                objAppShareData.shakeTextField(txtConfirmPassword)
            }else if txtConfirmPassword.text != txtPassword.text{
                objAppShareData.alertController(objVievController: self, message: "ConfirmPassword not currect")
            }else{
                
            }
    }
}

//MARK: Image picker method
fileprivate extension SignUpViewController{
    func selectProfileImage() {
        let selectImage = UIAlertController(title: "Select Profile Image", message: nil, preferredStyle: .actionSheet)
        let btn0 = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        let btn1 = UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.selectImageFromCamera()
        })
        let btn2 = UIAlertAction(title: "Photo Library", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.checkPhotoLibraryPermission()
        })
        selectImage.addAction(btn0)
        selectImage.addAction(btn1)
        selectImage.addAction(btn2)
        present(selectImage, animated: true)
    }
    
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            //handle authorized status
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.imagePicker.sourceType = .photoLibrary
                //  self.imagePicker.allowsEditing = true;
                self.present(self.imagePicker, animated: true)
            }
        //self.openGallary()
        case .denied, .restricted :
            //handle denied status
            let alert = UIAlertController(title: "Unable to access the Gallary",
                                          message: "To enable access, go to Settings > Privacy > Gallary and turn on Gallary access for this app.",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                        in
                        
                    })
                }
            })
            alert.addAction(settingsAction)
            
            present(alert, animated: true, completion: nil)
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized: break
                // as above
                case .denied, .restricted: break
                // as above
                case .notDetermined: break
                    // won't happen but still
                }
            }
        }
    }
    
    
    func selectImageFromCamera() //to Access Camera
    {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.denied {
            
            let alert = UIAlertController(title: "Unable to access the Camera",
                                          message: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app.",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { _ in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                        in
                        
                    })
                }
            })
            alert.addAction(settingsAction)
            
            present(alert, animated: true, completion: nil)
        }
        else if (authStatus == AVAuthorizationStatus.notDetermined) {
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    }
                }
            })
        } else {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                //self.imagePicker.allowsEditing = false;
                self.present(self.imagePicker, animated: true)
            }
            
        }
        
    }
}

//MARK: ------
fileprivate extension SignUpViewController{
    
}

//MARK: ------
fileprivate extension SignUpViewController{
    
}

//MARK: ------
fileprivate extension SignUpViewController{
    
}
