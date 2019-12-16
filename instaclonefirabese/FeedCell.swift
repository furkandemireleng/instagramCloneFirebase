//
//  FeedCell.swift
//  instaclonefirabese
//
//  Created by MacxbookPro on 27.11.2019.
//  Copyright © 2019 MacxbookPro. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
        //postlari cekebilmek icin yine veri tabanimiza bir eriselim
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            
            //likes yazmamiz veri tabanimizda oyle oldugu icin oyle string to any'yi firebase oyle istiyor diye yaptik
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
            //guncelleme islemi marge kismi ile yapildi geri kalan kisimlarda veriyi cektik
            
        }
        
        
    }
    
    
}
