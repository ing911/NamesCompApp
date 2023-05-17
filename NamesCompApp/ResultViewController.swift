//
//  ResultViewController.swift
//  NamesCompApp
//
//  Created by Пользователь on 18.05.2023.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstName: String?
    var secondName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    namesLabel.text = "\(firstName ?? "") and \(secondName ?? "")"

       
    }
    

    

}
