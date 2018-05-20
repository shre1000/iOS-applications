

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = getContext()
    var _fetchedResultsController: NSFetchedResultsController<Candy>? = nil
    var number1 : Int64 = 0
    var cname1 : String = ""
    var price1 : Double = 0.0
    var bname1 : String = ""
    var location1 : String = ""
    var year1 :Int64 = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let alert = UIAlertController(title: "New Brand and Candies", message: "Add please!", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler:
            { (action) in
                if let textfield0 = alert.textFields?[0]{
                    if let textfield1 = alert.textFields?[1]{
                        if let textfield2 = alert.textFields?[2]{
                            if let textfield3 = alert.textFields?[3]{
                                if let textfield4 = alert.textFields?[4]{
                                    if let textfield5 = alert.textFields?[5]{
                                        let bname = textfield0.text
                                        self.bname1 = bname!
                                        let location = textfield1.text
                                        self.location1 = location!
                                        let year : Int64 = Int64(textfield2.text!)!
                                        self.year1 = year
                                        let cname = textfield3.text
                                        self.cname1 = cname!
                                        let price : Double = Double(textfield4.text!)!
                                        self.price1 = price
                                        let number :Int64 = Int64(textfield5.text!)!
                                        self.number1 = number
                                    }
                                }
                                
                            }
                        }
                    }
                }
                else {
                    return
                }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter brand name"
        })
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter location"
        })
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter year"
        })
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter candy name"
        })
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter price of candy"
        })
        
        alert.addTextField(configurationHandler: {
            (textfield) in
            textfield.placeholder = "Enter number of candies"
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
        
        //saveCandyv2(name: NSDate())
        saveCandy(name: self.cname1, price: self.price1, number: self.number1, brand: getBrand(name: self.bname1, location: self.location1, year:self.year1))
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = self.fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let Candy = self.fetchedResultsController.object(at: indexPath)
        self.configureCell(cell, withCandy: Candy)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            saveContext(context: context)
        }
    }

    func configureCell(_ cell: UITableViewCell, withCandy Candy: Candy) {
        cell.textLabel!.text = Candy.name!.description
        let image : UIImage = UIImage(named: "Brand_Icon")!
        cell.imageView!.image = image
    }
}

