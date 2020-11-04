//
//  SignInViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/13.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {

    @IBOutlet weak var authEmailField: UITextField!
    @IBOutlet weak var authPasswordField: UITextField!
    @IBOutlet weak var signButton: UIView!
    @IBOutlet weak var googleButton: UIView!
    @IBOutlet weak var appleButton: UIView!
    
    @IBAction func logIn(_ sender: UIButton) {
        print("Testing Print")
        if let authEmail = authEmailField.text, let authPassword = authPasswordField.text {
            Auth.auth().signIn(withEmail: authEmail, password: authPassword) { (authResult, error) in
                if let err = error {
                    print(err.localizedDescription)
                    print(err)
                } else {
                    print("Succes Login!")
                    let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeViewController")
                    let searchView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "SearchViewController")
                    let tb = UITabBarController()
                    
                    tb.setViewControllers([homeView, searchView], animated: true)
                    tb.modalPresentationStyle = .fullScreen
                    self.present(tb, animated: true, completion: nil)
                }
                
            }
        }
    }

    @IBAction func findPassword(_ sender: UIButton) {
        print("finding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authEmailField.layer.borderWidth = 1.0
        authPasswordField.layer.borderWidth = 1.0
        authEmailField.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.0862745098, blue: 0.9960784314, alpha: 1)
        authPasswordField.layer.borderColor =  #colorLiteral(red: 0.3647058824, green: 0.08235294118, blue: 0.9960784314, alpha: 1)
        
        authEmailField.keyboardType = .emailAddress
        authPasswordField.isSecureTextEntry = true
        
        authEmailField.autocorrectionType = .no
        authPasswordField.autocorrectionType = .no
        
        authEmailField.tag = 0
        authPasswordField.tag = 1
        
        signButton.backgroundColor = UIColor.init(named: "Thema")
        
        googleButton.layer.shadowColor = UIColor.black.cgColor
        googleButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        googleButton.layer.shadowRadius = 5.0
        googleButton.layer.shadowOpacity = 0.4
        googleButton.layer.cornerRadius = 22.0
        googleButton.backgroundColor = UIColor.init(named: "GoogleThema")
        
        appleButton.layer.shadowColor = UIColor.black.cgColor
        appleButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        appleButton.layer.shadowOpacity = 0.4
        appleButton.layer.shadowRadius = 5.0
        appleButton.layer.cornerRadius = 22.0
        appleButton.backgroundColor = UIColor.label
        
    }
    
    

}
