//
//  ExhibitionWorksListViewController.swift
//  Expo1900
//
//  Created by 강인희 on 2020/12/22.
//

import UIKit

class ExhibitionWorksListViewController: UIViewController {

    @IBOutlet weak var workListTableView: UITableView!    
    var datasets = [ExhibitionWork]()

    //private var exhibitionWorks = [ExhibitionWork]()
    
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         guard let workDetailViewController = segue.destination as? WorkDetailViewController else {
//             return
//         }
        
//         if let index = sender as? Int {
//             workDetailViewController.workTitle = exhibitionWorks[index].name
//             workDetailViewController.workImageData = exhibitionWorks[index].image ?? UIImage()
//             workDetailViewController.workDescriptionContents = exhibitionWorks[index].description
//             workDetailViewController.navigationItem.title = workDetailViewController.workTitle
//         }
        
//     }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = "메인"
        self.navigationController?.navigationBar.topItem?.title = "한국의 출품작"
        decodeExhibitionData()
    }
    
    private func decodeExhibitionData() {
        self.workListTableView.rowHeight = 100

        let assetFile: String = "items"
        guard let asset = NSDataAsset(name: assetFile) else {
            fatalError("Can not found data asset.")
        }
        
        do {
//             exhibitionWorks = try JSONDecoder().decode([ExhibitionWork].self, from: asset.data)
//         } catch {
//             print("error: \(error)")
//         }
            datasets = try JSONDecoder().decode([ExhibitionWork].self, from: asset.data)
        } catch {
            print("error: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
            guard let vc = segue.destination as? ExhibitionWorkViewController else { return }
            guard let sender = sender as? Int else { return }
            vc.imageFile = datasets[sender].image
            vc.descriptionData = datasets[sender].description
        }
    }
}

extension ExhibitionWorksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: datasets[indexPath.row])
    }
}

extension ExhibitionWorksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasets.count
    }
    
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExhibitionWorkTableViewCell else {
//             fatalError("error발생")
//         }
        
//         cell.workImage.image = exhibitionWorks[indexPath.row].image
//         cell.workName.text = exhibitionWorks[indexPath.row].name
//         cell.workShortDescription.text = exhibitionWorks[indexPath.row].shortDescription
        
//     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell else {
            fatalError("error발생")
        }
        cell.thumbnail.image = datasets[indexPath.row].image
        cell.workName.text = datasets[indexPath.row].name
        cell.workDescription.text = datasets[indexPath.row].shortDescription
        return cell
    }
}
