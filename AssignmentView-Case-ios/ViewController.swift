//
//  ViewController.swift
//  AssignmentView-Case-ios
//
//  Created by Efe Kerem Kesgin on 5.09.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var imageAllData: ImageData?
    var imageAllLinks = [String]()
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData() {
        let url = URL(string: "https://prod-storyly-media.s3.eu-west-1.amazonaws.com/sdk-test-scenarios/assignment.json")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil else {
                print("Error Occured")
                return
            }
            var imageObject: ImageData?
            do
            {
                imageObject = try JSONDecoder().decode(ImageData.self, from: data)
            }
            catch
            {
                print("Error While Decoding Json into Swift \(error)")
            }
            self.imageAllData = imageObject
            self.imageAllLinks = self.imageAllData!.images
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
            
        })
        task.resume()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageAllLinks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        if let imageUrl = URL(string: imageAllLinks[indexPath.row]) {
            cell.myImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.myImageView.sd_imageIndicator?.stopAnimatingIndicator()
            cell.myImageView.sd_setImage(with: imageUrl,placeholderImage:
                                            UIImage(named:"emptyimage"),options: .continueInBackground, completed: nil)
            cell.myImageView.contentMode = .scaleToFill
        } else {
            print("Invaid URL - No Image")
            cell.myImageView.image = UIImage(named: "emptyimage")
        }
        return cell
    }
}


