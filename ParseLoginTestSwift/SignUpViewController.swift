//
//  ViewController.swift
//  ParseLoginTestSwift
//
//  Created by Aneesh Sachdeva on 1/1/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountButtonPressed(sender: AnyObject) {
        createAccount(self.emailTextField.text, password: self.passwordTextField.text)
    }
    
    func createAccount(email: String, password: String) {
        var newUser = PFUser()
        
        newUser.username = email // We want the user to login only with their email.
        newUser.email = email
        newUser.password = password
        
        newUser.signUpInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Account created successfully!
                if succeeded == true {
                    self.statusLabel.text = "Account created!"
                }
            }
            else {
                if let errorField = error.userInfo {
                    self.statusLabel.text = (errorField["error"] as NSString)
                }
                else {
                    // No userInfo dictionary present
                    // Help from http://stackoverflow.com/questions/25381338/nsobject-anyobject-does-not-have-a-member-named-subscript-error-in-xcode
                }
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

