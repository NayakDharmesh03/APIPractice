//
//  NewsTableViewCell.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 24/05/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsContentLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!

    @IBOutlet weak var myimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
