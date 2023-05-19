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
    
    // метод, срабатывающий при переходе с одного экрана на другой (из FirstVC -> ResultVC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
        // передаём данные из textField's первого экрана во второй экран
    }
    
    // метод, который будет срабатывать по нажатию на кнопку
    @IBAction func resultButtonTapped() {
        performSegue(withIdentifier: "goToResult", sender: nil)
        // данный метод используется для перехода по segue с идентификатором
        // переход с одного VC на другой происходит по segue с идентификатором
        // и при переходе также срабатывает метод prepare(for segue:) для передачи данных
    }
    
    // метод, с помощью которого мы возвращаемся из ResultVC во FirstVC
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else { return } // делаем проверку идентификатора ResultVC
        yourNameTF.text = ""
        partnerNameTF.text = ""
        // после возвращения в FirstVC очищаем поля обоих textField-ов
    }
}

extension FirstViewController: UITextViewDelegate {
    // метод, позвол. скрывать клав-ру тапом по экрану:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event) // вызываем метод у супер-класса
        view.endEditing(true)
    }
    // метод, позвол. при помощи экранной клав-ры переходить с 1-го поля textField на 2-е поле, а затем
    // по нажатию на кнопку "done" в клав-ре(!) вызывать метод для перехода на 2-й экран
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnerNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
}
