
import UIKit

class ExhibitionWorkDetailViewController: UIViewController {
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var workDescriptionLabel: UILabel!
    var workImage: UIImage?
    var workDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workImageView.image = workImage
        workDescriptionLabel.text = workDescription
    }
}

extension ExhibitionWorkDetailViewController: ExpositionWorkDelegate {
    func receive(information: ExhibitionWork) {
        workImage = information.image
        workDescription = information.description
        navigationItem.title = information.name
    }
}
