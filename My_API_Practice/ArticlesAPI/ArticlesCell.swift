//
//  UserDataGetCell.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit

class ArticlesCell: UITableViewCell {
    
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsPhoto.image = nil
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        newsPhoto.image = nil
//    }

}
