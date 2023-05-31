//
//  FetchDataVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 31/05/23.
//

import UIKit
import Alamofire

class FetchDataVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var homebnt: UIButton!
    @IBOutlet weak var myTblview: UITableView!
    

    var DataList = [Photos]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        let dataTask = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            
            guard let data = data , error == nil else{
                print("Error Occured while Accessing Data with URL")
                return
            }
          
            do{
                self.DataList = try JSONDecoder().decode([Photos].self, from: data)
            }catch{
                print("Error Occured while Decoding JSON into swift Structure  \(error)")
            }

            DispatchQueue.main.async {
                self.myTblview.reloadData()
            }
        }.resume()
    }
    
    //Like btn Action
    @IBAction func favBtnTapped(_ sender: UIButton) {
        
    }

        
    @IBAction func homeAction(_ sender: UIButton) {
        
        
    }
    @IBAction func favBtnAction(_ sender: UIButton) {
        
        
    }
    
}
extension FetchDataVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTblview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableDataCell
        cell.albumIdLbl.text = "albumId : \(DataList[indexPath.row].id)"
        cell.idLbl.text = "albumId : \(DataList[indexPath.row].title)"
        
//        cell.favImage.isSelected = DataList[indexPath.row].islike!
        
        if DataList[indexPath.row].url != nil
        {
            let url = URL(string: DataList[indexPath.row].url!)
            cell.myImageView.kf.setImage(with: url)
            cell.myImageView.downloadImage(from: url!)
            cell.myImageView.contentMode = .scaleAspectFill
        }
        else{
            cell.myImageView.image = UIImage(named: "NoImage")
        }
        
        
        
        return cell
    }
    
   
    
}
extension FetchDataVC :UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  nextVC = storyboard?.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
        nextVC.photo = DataList[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }

}
