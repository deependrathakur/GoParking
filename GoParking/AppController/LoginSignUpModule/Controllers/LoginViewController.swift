//
//  LoginViewController.swift
//  GoParking
//
//  Created by MAC HD on 30/08/19.
//  Copyright © 2019 MAC HD. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var txtPassword:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: System Method
 extension LoginViewController{
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

//MARK: Button method
fileprivate extension LoginViewController{
    @IBAction func btnLogin(_ sender:Any){
        self.view.endEditing(true)
        
        txtEmail.text = txtEmail.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        txtPassword.text = txtPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (sender as AnyObject).tag == 0{
            if txtEmail.text?.count == 0{
                objAppShareData.shakeTextField(txtEmail)
            }else if !objAppShareData.isValidEmail(emailStr:self.txtEmail.text ?? ""){
                objAppShareData.alertController(objVievController: self, message: "Please enter valid email address.")
            }else if txtPassword.text?.count == 0{
                objAppShareData.shakeTextField(txtPassword)
            }else if txtPassword.text?.count ?? 0 <= 5{
                objAppShareData.alertController(objVievController: self, message: "Please enter atleast 6 charactor password")
            }else{
                
            }
        }else if (sender as AnyObject).tag == 1{
           
        }else if (sender as AnyObject).tag == 2{
            
        }
    }
    
    @IBAction func btnSignUp(_ sender:Any){
        if let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main) as? UIStoryboard{
            if let objVC = storyboard.instantiateViewController(withIdentifier:"SignUpViewController") as? SignUpViewController{
                self.navigationController?.pushViewController(objVC, animated: true)
            }
        }
    }
    
    @IBAction func btnForgotPassword(_ sender:Any){
        objAppShareData.alertController(objVievController: self, message: "Under development")
    }
}

//MARK: ------
fileprivate extension LoginViewController{
    
}

//MARK: ------
fileprivate extension LoginViewController{
    
}

//MARK: ------
fileprivate extension LoginViewController{
    
}
