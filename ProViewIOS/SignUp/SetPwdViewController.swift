//
//  SetPwdViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/09.
//

import UIKit
import Firebase

class SetPwdViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var inputBottomLine: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        nextButton.isEnabled = false
        nextButton.backgroundColor = .gray
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        buttonAction()
//    }
    
    var email = ""
    func userEmail(id: String){
        email = id
    }

  
    @IBAction func tapNext(_ sender: UIButton) {
        
        if let email = String?(email), let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print("Error : \(e.localizedDescription)")
                } else {
                    print("Succes creating user!")
                    let storyboard = UIStoryboard.init(name: "Edit", bundle: nil)
                    let rootVC = storyboard.instantiateViewController(withIdentifier: "EditCardViewController")
                    let editVC = UINavigationController(rootViewController: rootVC)
                    editVC.modalPresentationStyle = .fullScreen
                    self.present(editVC, animated: true, completion: nil)
                }
            }
            
        }
    }
    
}

extension SetPwdViewController {
    @objc private func adjustInputView(noti: Notification) {
               guard let userInfo = noti.userInfo else { return }
               //MARK: 키보드 높이에 따른 인풋뷰 위치 변경
               guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
               
               if noti.name == UIResponder.keyboardWillShowNotification {
                   let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom + 16
                   inputBottomLine.constant = adjustmentHeight
               } else {
                   inputBottomLine.constant = 16
               }
       }
}

extension SetPwdViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text!.count > 8, textField.text!.count < 20 {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.init(named: "Thema")
        }
    }
}
