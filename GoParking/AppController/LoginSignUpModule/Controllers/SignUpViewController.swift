//
//  SignUpViewController.swift
//  GoParking
//
//  Created by MAC HD on 30/08/19.
//  Copyright © 2019 MAC HD. All rights reserved.
//

import UIKit
import Photos

class SignUpViewController: UIViewController{
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
                objAppShareData.alertController(objVievController: self, message: "Confirm password not currect")
            }else{
                
            }
    }
}

//MARK: Image picker method
extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func selectProfileImage() {
        let selectImage = UIAlertController(title: "Select Profile Image", message: nil, preferredStyle: .actionSheet)
        let btn0 = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        let btn1 = UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.openCamera11()
        })
        let btn2 = UIAlertAction(title: "Photo Library", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.openGallery11()
        })
        selectImage.addAction(btn0)
        selectImage.addAction(btn1)
        selectImage.addAction(btn2)
        present(selectImage, animated: true)
    }
    
    
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//        self.imageUserProfile.image = image
//    }
//    self.imagePicker.dismiss(animated: true, completion: nil)
//    imagePicker.dismiss(animated: false)
//
//  }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePicker.dismiss(animated: false)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                self.imageUserProfile.image = image
            }
            self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func openCamera11() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
              let imagePicker = UIImagePickerController()
              imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
              imagePicker.allowsEditing = false
              self.present(imagePicker, animated: true, completion: nil)
          } else {
              let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alert, animated: true, completion: nil)
          }
      }
    
    func openGallery11() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
