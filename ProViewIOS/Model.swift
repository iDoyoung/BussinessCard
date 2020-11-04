//
//  Model.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/05.
//

import Foundation
import Firebase

class Model {
        
        //var cards: [Card]
        var cards: [Card] = []
    
        var card = Card(userName: "", userJob: "", emailAdress: "", phoneNumber: "", imageUrl: "", company: "", companyLocation: "", companyDomain: "", companyPhone: "", fax: "")
    
        struct Card {
            let userName: String?
            let userJob: String?
            let emailAdress: String?
            let phoneNumber: String?
            let imageUrl: String?
            
            let company: String?
            let companyLocation: String?
            let companyDomain: String?
            let companyPhone: String?
            let fax: String?
        }
        
        let db = Firestore.firestore()
        //let currentUser = Auth.auth().currentUser?.email
        
//    init(user: String) {
//        db.collection("MyCardIndo").addSnapshotListener { querySnapshot, error in
//            self.cards = []
//            if  let e = error {
//                print("There was an issue retrieving data from Fire. \(e)")
//            } else {
//                if let snapShotDocument = querySnapshot?.documents {
//                    for doc in snapShotDocument {
//                        let data = doc.data()
//                        let name = data[Const.FStore.nameField]  as? String
//                        let job = data[Const.FStore.jobField] as? String
//                        let email = data[Const.FStore.emailField] as? String
//                        let mobile = data[Const.FStore.mobileField] as? String
//                        let logoUrl = data[Const.FStore.companyLogoUrl] as? String
//                        let company = data[Const.FStore.companyName] as? String
//                        let companyLocation = data[Const.FStore.companyAdress] as? String
//                        let companyDomain = data[Const.FStore.companyDomain] as? String
//                        let companyPhone = data[Const.FStore.companyPhone] as? String
//                        let companyFax = data[Const.FStore.companyFax] as? String
//                        let newCard = Card(userName: name, userJob: job, emailAdress: email, phoneNumber: mobile, imageUrl: logoUrl, company: company, companyLocation: companyLocation, companyDomain: companyDomain, companyPhone: companyPhone, fax: companyFax)
//                        self.cards.append(newCard)
//                        print(newCard.company!)
//                    }
//                } else {
//                    print("Document does not exist")
//                }
//            }
//        }
//    }
    
    init(user: String) {
        db.collection("MyCardIndo").document(user)
            .addSnapshotListener { (documentSnapshot, error) in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                let name = data[Const.FStore.nameField]  as? String
                let job = data[Const.FStore.jobField] as? String
                let email = data[Const.FStore.emailField] as? String
                let mobile = data[Const.FStore.mobileField] as? String
                let logoUrl = data[Const.FStore.companyLogoUrl] as? String
                let company = data[Const.FStore.companyName] as? String
                let companyLocation = data[Const.FStore.companyAdress] as? String
                let companyDomain = data[Const.FStore.companyDomain] as? String
                let companyPhone = data[Const.FStore.companyPhone] as? String
                let companyFax = data[Const.FStore.companyFax] as? String
                let newCard = Card(userName: name, userJob: job, emailAdress: email, phoneNumber: mobile, imageUrl: logoUrl, company: company, companyLocation: companyLocation, companyDomain: companyDomain, companyPhone: companyPhone, fax: companyFax)
                self.card = newCard
            }
    }
                
        func deleteInfo(collectionName: String, documnetName: String) {
            db.collection(collectionName).document(documnetName).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    
    
        
        func logout() {
            do {
                try Auth.auth().signOut()
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                UIViewController().present(loginVC, animated: true, completion: nil)
            } catch let signOutError as NSError{
                print("Error signing out: %@", signOutError)
            }
        }
}
