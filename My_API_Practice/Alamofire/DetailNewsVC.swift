//
//  DetailNewsVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 31/05/23.
//

import UIKit

class DetailNewsVC: UIViewController {
    
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    var newsContent : ArticleData = ArticleData(author: "", title: "", urlToImage: "", content: "")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        headlineLbl.text = newsContent.title
        
        //if newsContent data are nil then set geted image
        if newsContent.urlToImage != nil{
            let url = URL(string: newsContent.urlToImage!)
            newsPhoto.downloadImage(from: url!)
            newsPhoto.contentMode = .scaleAspectFill
        }
        else{
            //then no image set bydefault
            newsPhoto.image = UIImage(named: "NoImage")
        }
        contentLbl.text = newsContent.content
    }
    


}
