//
//  ViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/05.
//

import UIKit
import Firebase
import GoogleSignIn

class MainViewController: UIViewController {
    @IBOutlet weak var signUpUI: UIView!
    @IBOutlet weak var googleButtonUI: UIView!
    @IBOutlet weak var appleButtonUI: UIView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func googSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let destination = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "SetIdViewController")
        let destinationVC = UINavigationController(rootViewController: destination)
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        print("sign in")
        performSegue(withIdentifier: "SignIn", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func updateView() {
        signUpUI.backgroundColor = UIColor.init(named: "Thema")
        signUpUI.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        signUpUI.layer.shadowRadius = 5.0
        signUpUI.layer.shadowColor = UIColor.black.cgColor
        signUpUI.layer.shadowOpacity = 0.4
        signUpUI.layer.cornerRadius = 22.0
        
        googleButtonUI.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.9568627451, alpha: 1)
        googleButtonUI.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        googleButtonUI.layer.shadowRadius = 5.0
        googleButtonUI.layer.shadowColor = UIColor.black.cgColor
        googleButtonUI.layer.shadowOpacity = 0.4
        googleButtonUI.layer.cornerRadius = 22.0
        
        appleButtonUI.backgroundColor = UIColor.black
        appleButtonUI.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        appleButtonUI.layer.shadowColor = UIColor.black.cgColor
        appleButtonUI.layer.shadowOpacity = 0.4
        appleButtonUI.layer.shadowRadius = 5.0
        appleButtonUI.layer.cornerRadius = 22.0
    }
}



extension MainViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authRes, error) in
                if let err = error{
                    print(err)
                }else{
                    print ("Succes Login!")
                    let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeViewController")
                    let searchView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "SearchViewController")
                    let tb = UITabBarController()
                    tb.setViewControllers([homeView, searchView], animated: true)
                    self.present(tb, animated: true, completion: nil)
                }
            }
        }
    }
}
