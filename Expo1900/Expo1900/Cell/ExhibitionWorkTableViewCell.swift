//
//  ExhibitionWorkTableViewCell.swift
//  Expo1900
//
//  Created by 강인희 on 2020/12/24.
//

import UIKit

class ExhibitionWorkTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var workNameLabel: UILabel!
    @IBOutlet weak var workDescriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        workNameLabel.text = nil
        workDescriptionLabel.text = nil
    }
    
    func setUpUI(with work: ExhibitionWork) {
        thumbnailImageView.image = work.image
        workNameLabel.text = work.name
        workDescriptionLabel.text = work.shortDescription
    }
}
