//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var expositionName: UILabel!
    @IBOutlet weak var expositionPoster: UIImageView!
    @IBOutlet weak var numberOfVisitor: UILabel!
    @IBOutlet weak var expositionPlace: UILabel!
    @IBOutlet weak var expositionDuration: UILabel!
    @IBOutlet weak var expositionDescription: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var expositionInformationView: UIView!
    
    @IBOutlet weak var expositionDescriptionHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeExpositionData()
        setUpConstraints()
        setUpBorderLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "메인"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func decodeExpositionData() {
        let assetFile: String = "exposition_universelle_1900"
        guard let asset = NSDataAsset(name: assetFile) else {
            fatalError("Can not found data asset.")
        }
        
        do {
            let dataModel = try JSONDecoder().decode(ExpositionInformation.self, from: asset.data)
            updateUIFields(with: dataModel)
        } catch {
            print("error: \(error)")
        }
    }
    
    private func setUpConstraints() {
        expositionDescription.isEditable = false
        expositionDescription.isScrollEnabled = false
        expositionDescriptionHeightConstraint.constant = expositionDescription.contentSize.height
    }
    
    private func setUpBorderLayer() {
        expositionInformationView.layer.borderColor = UIColor.black.cgColor
        expositionInformationView.layer.borderWidth = 3
    }
    
    private func updateUIFields(with model: ExpositionInformation) {
        var title = model.title
        expositionName.text = "\(title.textFormatted())"
        expositionPoster.image = #imageLiteral(resourceName: "poster")
        numberOfVisitor.text = "방문객 : \(model.visitors.numberFormatted()) 명"
        expositionPlace.text = "개최지 : \(model.location)"
        expositionDuration.text = "개최 기간 : \(model.duration)"
        expositionDescription.text = model.description
        nextButton.setTitle("한국의 출품작 보러가기", for: .normal)
    }
}
fileprivate extension String {
    mutating func textFormatted() -> String {
        if let newLineIndex = self.firstIndex(of: "(") {
            self.insert("\n", at: newLineIndex)
        }
        
        return self
    }
}
fileprivate extension Int {
    func numberFormatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSize = 3
        numberFormatter.numberStyle = .decimal
        
        guard let visitor = numberFormatter.string(for: self) else {
            return ""
        }
        
        return visitor
    }
}
