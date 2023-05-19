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
    
    // метод, срабатывающий при переходе с одного экрана на другой (из FirstVC -> ResultVC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
        // передаём данные из textField's первого экрана во второй экран
    }
    
    // метод, который будет срабатывать по нажатию на кнопку
    @IBAction func resultButtonTapped() {
        // извлекаем опциональные значения из строк, введённых в текстовые поля:
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else { return }
        // если одна или обе текстовые строки пустые, вызываем алёрт:
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(title: "Names are missing",
                      message: "Please enter both names 😊") // эмодзи ctrl + cmd + пробел
            return
        }
        // если оба текстовых поля не будут пустыми и условие не будет соблюдаться, будем переходить на след. экран:
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

    // создаём алёрт
extension FirstViewController {
    private func showAlert(title: String, message: String) {
        // внутри метода создаём экземпляр класса UIAlertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // создаём экземпляр класса UIAlertAction
        let okAction = UIAlertAction(title: "OK", style: .default) // создаём кнопку "ОК" для алёрта
        alert.addAction(okAction) // добавляем кнопку "ОК"
        present(alert, animated: true) // отображаем алёрт-контроллер
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
