

import Foundation
import UIKit


class ViewController: UITableViewController   {
    var entities = [[String:Any]]()
    let urlString = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadData(urlString)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func  loadData (_ url : String) {
        let url = URL(string: self.urlString)
        let coniguration = URLSessionConfiguration.default
        let session = URLSession(configuration: coniguration)
        let task = session.dataTask(with: url!) { (data, response, error) in
            //var error: Error?
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            let feed = json["feed"] as! [String:Any]
            self.entities = feed["entry"] as! [[String:Any]]
            self.tableView.reloadData()
            
        }
        task.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.entities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomTableViewCell
        let entry = self.entities[indexPath.row] as [String:Any]
        
        let im_name = entry["im:name"] as! [String:Any]
        let im_name_label = im_name["label"] as! String
        
        let im_price = entry["im:price"] as! [String:Any]
        let im_price_label = im_price["label"] as! String
        
        let im_release_date = entry["im:releaseDate"] as! [String:Any]
        let im_release_date_attribute = im_release_date["attributes"] as! [String:Any]
        let im_release_date_attribute_label = im_release_date_attribute["label"] as! String
        
        cell.TitleLbel.text = im_name_label
        cell.PriceLabel.text = im_price_label
        cell.ReleaseDate.text = im_release_date_attribute_label
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = self.entities[indexPath.row] as [String:Any]
            let controller = segue.destination as! DetailViewController
            controller.entry = object
            
        }
    }
    
    
    
}

class MyCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var TitleLbel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ReleaseDate: UILabel!
    
   }

