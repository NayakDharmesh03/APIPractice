//
//  UserDataGetVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit
import Kingfisher

class GetArticles: UIViewController {

    var articlesList : [ArticleData] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArticlesCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func downloadPhotosAction(_ sender: UIButton) {
        fetchData()
    }
    func fetchData() {
        let url = URL(string:"https://newsapi.org/v2/top-headlines?country=us&apiKey=09e6198529ea454189a331720ef016a7" )
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data , error == nil else{
                print("Error Occured while Accessing Data with URL")
                return
            }
            var newsFullList : NewsData?
            do{
                newsFullList = try JSONDecoder().decode(NewsData.self, from: data)
            }catch{
                print("Error Occured while Decoding JSON into swift Structure  \(error)")
            }
            self.articlesList = newsFullList!.articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
        
    }

}
extension UIImageView {
    func downloadImage(from url: URL){
        contentMode = .scaleAspectFill
        
        let dataTask = URLSession.shared.dataTask(with: url,completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,let mimeType = response?.mimeType,mimeType.hasPrefix("image"),
    let data = data, error == nil,
            let image = UIImage(data: data) else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
extension GetArticles : UITableViewDataSource , UITableViewDelegate{
    // Implement UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticlesCell
        
        
        if articlesList[indexPath.row].author != nil{
            cell.authorLbl.text = "Author: \(articlesList[indexPath.row].author!)"
            
        }
        else{
            
            cell.authorLbl.text = "No Author available"
        }
        
        cell.headlineLbl.text = articlesList[indexPath.row].title
        
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

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  nextVC = storyboard?.instantiateViewController(withIdentifier: "DetailArticles") as! DetailArticles
        nextVC.newsContent = articlesList[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
