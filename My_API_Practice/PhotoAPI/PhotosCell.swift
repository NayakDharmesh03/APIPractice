//
//  PhotosCell.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit

class PhotosCell: UITableViewCell {
    @IBOutlet weak var UrlImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var thumbnailUrlImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
