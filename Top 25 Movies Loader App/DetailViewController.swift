//
//  ViewController.swift
//  Corrected_shreyasi_movies
//
//  Created by Kokam on 5/5/17.
//  Copyright © 2017 Kokam. All rights reserved.
//  This is final version.

import Foundation
import UIKit
import StoreKit

class DetailViewController : UIViewController, SKStoreProductViewControllerDelegate {

    var entry = [String:Any]()
    var id_address : String = ""
    
    @IBOutlet weak var PosterView: UIImageView!
    @IBOutlet weak var Tittle: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ReleaseDate: UILabel!
    
    @IBAction func buttonclicked(sender: UIButton){
        open(url: id_address)
      //openStoreProductWithiTunesItemIdentifier(identifier: "687505681")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let im_name = entry["im:name"] as! [String:Any]
        let im_name_label = im_name["label"] as! String
        
        let im_price = entry["im:price"] as! [String:Any]
        let im_price_label = im_price["label"] as! String
        
        let im_release_date = entry["im:releaseDate"] as! [String:Any]
        let im_release_date_attributes = im_release_date["attributes"] as! [String:Any]
        let im_release_date_attributes_label = im_release_date_attributes["label"] as! String
        
        let id = entry["id"] as! [String:Any]
        let id_label = id["label"] as! String
        let truncated = String(id_label.characters.dropLast(5))
        id_address = truncated
        
        let image = entry["im:image"] as! [[String:Any]]
        let image_object = image[0] as [String:Any]
        let image_label = image_object["label"] as! String
        
        
        let URLString = image_label
        let url = URL(string: URLString)
        let request = URLRequest(url: url!)
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                DispatchQueue.main.async {
                    self.PosterView.image = UIImage(data: data)
                }
                
            }
        })
        task.resume()
        
        
        self.Tittle.text =  im_name_label
        self.Price.text = im_price_label
        self.ReleaseDate.text = im_release_date_attributes_label
            
        }
    
    
    //didn't use this approach
    func openStoreProductWithiTunesItemIdentifier(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    func  open(url : String) {
    
       if let url1 = URL(string: url){
        UIApplication.shared.openURL(url1)
    }
        
    }

}
    
    


