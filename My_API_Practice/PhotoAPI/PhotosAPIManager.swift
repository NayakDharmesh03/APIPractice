//
//  PhotosAPIManager.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 25/05/23.
//

import UIKit

class PhotosAPIManager: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var photos: [Photos] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PhotosCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    @IBAction func downloadPhotosAction(_ sender: Any) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
                    return
                }

                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
                        // Handle the error
                        return
                    }

                    do {
                        self?.photos = try JSONDecoder().decode([Photos].self, from: data)
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    } catch {
                        // Handle the error
                    }
                }.resume()
    }
    

}
extension PhotosAPIManager : UITableViewDataSource{
    // Implement UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PhotosCell
        let photo = photos[indexPath.row]
        cell.idLbl.text = String(photo.id)
        cell.titleLbl.text = photo.title
        
        // Load the images asynchronously
               DispatchQueue.global().async {
                   if let imageData = try? Data(contentsOf: photo.url),
                      let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           cell.UrlImage.image = image
                           cell.setNeedsLayout()
                       }
                   }
                   
                   if let thumbnailData = try? Data(contentsOf: photo.thumbnailUrl),
                      let thumbnailImage = UIImage(data: thumbnailData) {
                       DispatchQueue.main.async {
                           cell.thumbnailUrlImage.image = thumbnailImage
                           cell.setNeedsLayout()
                       }
                   }
               }
        
        return cell
    }

    
    
}
