//
//  NewsTableCell.swift
//  
//
//  Created by MacbookAir_32 on 29/05/23.
//

import UIKit

class NewsTableCell: UITableViewCell {

    @IBOutlet weak var newsContentLbl: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var newsTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
