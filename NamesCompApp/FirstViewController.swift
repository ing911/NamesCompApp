//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Пользователь on 17.05.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnerNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func resultButtonTapped() {
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
}

extension FirstViewController: UITextViewDelegate {
    // метод, позвол. скрывать клав-ру тапом по экрану:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event) // вызываем метод у супер-класса
        view.endEditing(true)
    }
    // метод, позвол. при помощи экранной клав-ры переходить с 1-го поля на 2-е поле, а затем
    // по нажатию на кнопку "да" вызывать метод для перехода на 2-й экран
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnerNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
}
