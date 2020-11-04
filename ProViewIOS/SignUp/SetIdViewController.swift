//
//  SetIdViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/09.
//

import UIKit

class SetIdViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var inputBottomLine: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.keyboardType = .emailAddress
        
        let dismissButton = UIBarButtonItem(title: "Cancle", style: .plain, target: self, action: #selector(goMain))
        self.navigationItem.leftBarButtonItem = dismissButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.becomeFirstResponder()
        self.title = "Sign up"
    }
    
    // model 로 뺄수 있으면 빼기
    @objc func goMain() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let signUpVC = segue.destination as? SetPwdViewController
            signUpVC?.userEmail(id: emailTextField.text!)
        }
    }
    
    @IBAction func tapNext(_ sender: UIButton) {
        if let setEmail = emailTextField.text {
            if isValidEmail(setEmail) {
                performSegue(withIdentifier: "Next", sender: self)
            } else {
                print(" !!! \(setEmail) donesn't look liek an email address.")
            }
        }
    }
  
}

func isValidEmail(_ email: String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    return emailPred.evaluate(with: email)
}

extension SetIdViewController {
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
