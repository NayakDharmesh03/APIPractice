//
//  ImagesTableViewCell.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 26/05/23.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = UIImage(named: "NoImage")
    }


}
