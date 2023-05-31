//
//  TableDataCell.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 31/05/23.
//

import UIKit

class TableDataCell: UITableViewCell {

    @IBOutlet weak var favImage: UIButton!
    @IBOutlet weak var albumIdLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
