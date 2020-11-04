//
//  EditCardViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/09.
//

import UIKit
import Firebase

class EditCardViewController: UIViewController {

    @IBOutlet weak var cardBG: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var jobField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var inputBottomLine: NSLayoutConstraint!
    
    @IBAction func next(_ sender: UIButton) {
        if nameField.text == "" || jobField.text == "" || mobileField.text == "" {
            let alert = UIAlertController(title: "Uncomplete", message: "You must fill all blank.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "Next", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let homeButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(home))
        
        self.navigationItem.leftBarButtonItem = homeButton
        
        emailLabel.text = Auth.auth().currentUser?.email
        cardBG.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        cardBG.layer.shadowOpacity = 0.25
        cardBG.layer.shadowColor = UIColor.black.cgColor
        cardBG.layer.shadowRadius = 8.0
        
        nameField.becomeFirstResponder()
        nameField.tag = 0
        nameField.delegate = self
        nameField.autocorrectionType = .no
        
        
        jobField.tag = 1
        jobField.delegate = self
        jobField.autocorrectionType = .no
        
        mobileField.tag = 2
        mobileField.delegate = self
        mobileField.autocorrectionType = .no

        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            if let vc = segue.destination as? EditCompanyViewController {
                vc.updateData(am: nameField.text!, do: jobField.text!, is: mobileField.text!)
            }
        }
    }
    
    @objc func home() {
        self.performSegue(withIdentifier: "unwindToMainVC", sender: self)
    }
    
}

extension EditCardViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if nameField.text != "" && jobField.text != "" && mobileField.text != "" {
            print("")
        } else {
            print("")
        }
    }
}

extension EditCardViewController {
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
