//
//  LazyLoadingImageVC.swift
//  My_API_Practice
//
//  Created by MacbookAir_32 on 26/05/23.
//

import UIKit

class LazyLoadingImageVC: UIViewController {
    
    @IBOutlet weak var myCollectionview: UICollectionView!
    
    var dogAllData:DogData?
    var dogImagesAllLinks = [String]()
    var imageCatchData = NSCache<NSString,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshDataAction(_ sender: UIBarButtonItem) {
        
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
                self.myCollectionview.reloadData()
            }
            
        }
        task.resume()
    }

}

extension LazyLoadingImageVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    //UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImagesAllLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = myCollectionview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LazyLoadingCollectionCell
        
        let urlImage = URL(string: (dogAllData?.message[indexPath.row])!)
        cell.myImage.downloadImage(from: urlImage!,imgCachData: imageCatchData,counter: String(indexPath.row))
        cell.myImage.layer.cornerRadius = 10
        return cell
        
    }
    
    //UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        // Return the desired size for the item at the given index path
        return CGSize(width: size, height: size)
    }
    
}
//Image Downoding and save in Cach
extension UIImageView{
    func downloadImage(from url:URL,imgCachData:NSCache<NSString,UIImage>,counter:String){
        image = UIImage(named: "NoImage")
        
        //Image Downoding and save in Cach
        if let savedImage = imgCachData.object(forKey: NSString(string: counter))
        {
            DispatchQueue.main.async {
                self.image = savedImage
                print("Fetching Images from ImageCach for Image No \(counter)")
            }
        }
        else
        {
            //if image are not in cach then start sessoin task and save in cach
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,let mimeType = response?.mimeType,mimeType.hasPrefix("image"),
        let data = data, error == nil,
                let image = UIImage(data: data) else{
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                    imgCachData.setObject(image, forKey: NSString(string: counter))
                    print("Fetching Images from ImageCach for Image No \(counter)")
                }
            }
            task.resume()
        }
    }
}
