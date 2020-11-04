//
//  ViewModel.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/05.
//

import Foundation
import Firebase

class ViewModel {
    
    let db = Firestore.firestore()
    
    var model: Model = ViewModel.loadMyCard()
    
    static let currentUser = Auth.auth().currentUser?.email
    
    static func loadMyCard() -> Model {
        let user = String(self.currentUser!)
        print(user)
        return Model(user: user)
    }
    
    let userEmail = Auth.auth().currentUser?.email
    
    var card: Model.Card {
        return  ViewModel.loadMyCard().card
    }
    var cards: [Model.Card] {
        model.cards
    }

    func logout() {
        model.logout()
    }
    
    func delete(in collection: String, about name: String){
        model.deleteInfo(collectionName: collection, documnetName: name)
    }
    
    func setData(collectionName: String, documentName: String, name: String, job: String, email: String, mobile: String, company: String, location: String, domain: String, companyPhone: String, fax: String) {
            db.collection(collectionName).document(documentName).setData([
                Const.FStore.nameField: name,
                Const.FStore.jobField: job,
                Const.FStore.emailField: email,
                Const.FStore.mobileField: mobile,
                Const.FStore.companyName: company,
                Const.FStore.companyAdress: location,
                Const.FStore.companyDomain: domain,
                Const.FStore.companyPhone: companyPhone,
                Const.FStore.companyFax: fax
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Successfully saved data.")
//                    self.performSegue(withIdentifier: "SuccessMakingCard", sender: self)
                }
            }
    }
    
}
