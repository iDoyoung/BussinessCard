//
//  CardViewCell.swift
//  ProViewIOS
//
//  Created by ido on 2020/10/05.
//

import UIKit
import Kingfisher

class CardViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBG.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        cardBG.layer.shadowOpacity = 0.25
        cardBG.layer.shadowColor = UIColor.black.cgColor
        cardBG.layer.shadowRadius = 7.0
    }

    @IBOutlet weak var cardBG: UIView!
    
    @IBOutlet weak var companyLogo: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var emailAdress: UILabel!
    
    @IBOutlet weak var mobileNumber: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var companyLocation: UILabel!
    
    @IBOutlet weak var companyNumber: UILabel!
    
    @IBOutlet weak var companyFax: UILabel!
    
    func updateCardUI(card: Model.Card) {
        nameLabel.text = card.userName
        jobLabel.text = card.userJob
        emailAdress.text = card.emailAdress
        mobileNumber.text = card.phoneNumber
        companyName.text = card.company
        companyLocation.text = card.companyLocation
        companyNumber.text = card.companyPhone
        companyFax.text = card.fax
    }
//        let imageURL = viewModel.card.imageUrl
//        let domain = viewModel.card.companyDomain
//        if imageURL != ""{
//            let url = URL(string: imageURL!)
//            let task = URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
//                if error != nil{
//                    print(error!)
//                    return
//                }
//                DispatchQueue.main.async {
//                    self.companyLogo.image = UIImage(data: data!)
//                }
//            }
//            task.resume()
//        } else if domain != "" {
//            let url = URL(string: "https://logo.clearbit.com/\(domain)")
//            self.companyLogo.kf.setImage(with: url)
//        }else {
//            self.companyLogo.isHidden = true
//        }
//    }
}
