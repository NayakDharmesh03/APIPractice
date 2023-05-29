//
//  AlamofireVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 29/05/23.
//

import UIKit
import Alamofire

class AlamofireVC: UIViewController {

    var articlesList = [ArticleData]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()
    }
    func getNewsData(){
       
        AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=09e6198529ea454189a331720ef016a7").response { response in
            if let data = response.data{
                var newsFullList : NewsData?
                do{
                    newsFullList = try JSONDecoder().decode(NewsData.self, from: data)
                }catch{
                    print("Error Occured while Decoding JSON into swift Structure  \(error)")
                }
                self.articlesList = newsFullList!.articles
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        }
    }

}
extension AlamofireVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        
        cell.newsTitleLbl.text = articlesList[indexPath.row].title
        cell.newsContentLbl.text = articlesList[indexPath.row].content
        if articlesList[indexPath.row].urlToImage != nil
        {
            let url = URL(string: articlesList[indexPath.row].urlToImage!)
            cell.newsPhoto.kf.setImage(with: url)
            cell.newsPhoto.downloadImage(from: url!)
            cell.newsPhoto.contentMode = .scaleAspectFill
        }
        else{
            cell.newsPhoto.image = UIImage(named: "NoImage")
        }
        
        
        return cell
    }
}
