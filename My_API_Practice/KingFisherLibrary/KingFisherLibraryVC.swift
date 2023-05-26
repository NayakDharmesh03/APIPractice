//
//  KingFisherLibraryVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 26/05/23.
//

import UIKit
import Kingfisher

class KingFisherLibraryVC: UIViewController {
    @IBOutlet weak var myTableView: UITableView!

    var dogAllData:DogData?
    var dogImagesAllLinks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func downloadDataAction(_ sender: UIButton) {
        fetchData()
    }
    func fetchData(){
        
        let url = URL(string:"https://dog.ceo/api/breed/hound/images")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data, error == nil else
            {
                print("Error Occurd while Accessing Data")
                return
            }
            var dogObject : DogData?
            do
            {
                dogObject = try JSONDecoder().decode(DogData.self,from: data)
            }catch{
                print("Error Occurd while Decoding JSON into Swift structure")
            }
            self.dogAllData = dogObject
            self.dogImagesAllLinks = self.dogAllData!.message
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        }
        task.resume()
    }
}
extension KingFisherLibraryVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogImagesAllLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImagesTableViewCell
        cell.subView.layer.cornerRadius = 15
        if let urlImage = URL(string: dogImagesAllLinks[indexPath.row])
        {
            cell.myImageView.kf.setImage(with: urlImage)
//            cell.myImageView.layer.cornerRadius = 15

        }
        else
        {
            print("Invalid - No Image")
            cell.myImageView.image = UIImage(named: "NoImage")
        }
        return cell
    }
    
    
}
