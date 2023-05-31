//
//  FavoritesVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 31/05/23.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var albumIdLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var favBtn: UIButton!
    
    var photo : Photos = Photos(id: "", title: "", url: "", thumbnailUrl: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumIdLbl.text = photo.id
        
        if photo.url != nil{
            let url = URL(string: photo.url!)
            myImageView.downloadImage(from: url!)
            myImageView.contentMode = .scaleAspectFill
        }
        else{
            myImageView.image = UIImage(named: "NoImage")
        }
        titleLbl.text = photo.title
       
    }
    
}
