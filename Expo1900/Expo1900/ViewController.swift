//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expositionName: UILabel!
    @IBOutlet weak var expositionPoster: UIImageView!
    
    @IBOutlet weak var numberOfVisitor: UILabel!
    @IBOutlet weak var expositionPlace: UILabel!
    @IBOutlet weak var expositionDuration: UILabel!
    @IBOutlet weak var expositionDescription: UITextView!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        expositionDescription.isEditable = false
    }
}

