
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
    func receive(work: ExhibitionWork) {
        workImage = work.image
        workDescription = work.description
        navigationItem.title = work.name
    }
}
