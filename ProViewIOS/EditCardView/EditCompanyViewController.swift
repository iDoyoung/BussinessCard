//
//  EditCompanyViewController.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/09.
//

import UIKit
import Firebase

class EditCompanyViewController: UIViewController {

    let viewModel = ViewModel()
    
    var userName = ""
    var userJob = ""
    var userMobile = ""
    
 
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyAdress: UILabel!
    @IBOutlet weak var companyDomain: UITextField!
    @IBOutlet weak var companyPhone: UITextField!
    @IBOutlet weak var companyFax: UITextField!
    
    @IBOutlet weak var inputBottomLine: NSLayoutConstraint!
    
    @IBAction func setLocation(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Map", bundle: nil)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "SearchLocationViewController") as! SearchLocationViewController
        let navController = UINavigationController(rootViewController: mapVC)
        mapVC.delegate = self
        showDetailViewController(navController, sender: self)
    }
    
    @IBAction func done(_ sender: UIButton) {
        viewModel.setData(collectionName: "MyCardIndo", documentName: viewModel.userEmail!, name: userName, job: userJob, email: viewModel.userEmail!, mobile: userMobile, company: companyName.text!, location: companyAdress.text!, domain: companyDomain.text!, companyPhone: companyPhone.text!, fax: companyFax.text!)
        let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeViewController")
        let searchView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "SearchViewController")
        let tb = UITabBarController()
        tb.setViewControllers([homeView, searchView], animated: true)
        self.present(tb, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.isHidden = true
        companyDomain.tag = 0
        companyDomain.delegate = self
        
        companyPhone.tag = 1
        companyPhone.delegate = self
        
        companyFax.tag = 2
        companyFax.delegate = self
        
        companyDomain.autocorrectionType = .no
        companyPhone.autocorrectionType = . no
        companyFax.autocorrectionType = .no
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    func updateData(am name: String,do job: String,is mobile: String) {
        userName = name
        userJob = job
        userMobile = mobile
    }

}

extension EditCompanyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
        return false
    }
}

extension EditCompanyViewController: SetCompanyDelegate {
    
    func setCompanyInfo(name: String?, location: String?) {
            self.companyName.text = name
            self.companyAdress.text = location
            self.bgView.isHidden = false
            self.companyDomain.becomeFirstResponder()
//            self.subtitleLabel.isHidden = true
//            self.doneButton.titleLabel?.text! = "DONE"
    }
}

extension EditCompanyViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else {
            return
        }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom + 8
            inputBottomLine.constant = adjustmentHeight
        } else {
            inputBottomLine.constant = 8
        }
    }
}
