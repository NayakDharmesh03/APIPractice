//
//  DetailArticles.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit

class DetailArticles: UIViewController {
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    var newsContent : ArticleData = ArticleData(author: "", title: "", urlToImage: "", content: "")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        headlineLbl.text = newsContent.title
        
        if newsContent.urlToImage != nil{
            let url = URL(string: newsContent.urlToImage!)
            newsPhoto.downloadImage(from: url!)
            newsPhoto.contentMode = .scaleAspectFill
        }
        else{
            newsPhoto.image = UIImage(named: "NoImage")
        }
        contentLbl.text = newsContent.content
    }
    


}
