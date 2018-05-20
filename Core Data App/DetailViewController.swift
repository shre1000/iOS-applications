
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
               // label.text = "candy name is " + detail.name!.description + "price is " + //detail.price.description + "number " + detail.number.description + " Brand: " + detail.brand!.name!.description + "was established in " + detail.brand!.year.description + "location is " + detail.brand!.location!.description
                label.text = "candy name is " + detail.name!.description + " Brand: " + detail.brand!.name!.description             }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Candy? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

