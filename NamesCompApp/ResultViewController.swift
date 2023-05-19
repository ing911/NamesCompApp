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
    
    var firstName: String!
    var secondName: String!
    
    private var resultValue = 0 // используется для расчёта результата совместимости имён
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultValue = findResult() // получаем нужное число ("соответстивие" имён)
        namesLabel.text = "\(firstName ?? "") and \(secondName ?? "")" // тест с именами
        resultLabel.text = resultValue.formatted(.percent) // число в процентах %
        progressView.progress = Float(resultValue) / 100 // шкала прогресса
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4) // делаем progressView толще и заметнее
    }
    
    // метод, который будет срабатывать по нажатию на кнопку
    // указываем момент, в котором будет срабатывать переход по кнопке из ResultVC -> FirstVC
    @IBAction func backButtonTapped() {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
        // теперь переход у нас привязан к самому VC(ResultVC), а не к кнопке
    }
    
    // функция, с помощью которой мы получаем некоторое число для имени
    private func findValue(for name: String) -> Int {
        var count = 0
        
        for character in name.lowercased() {
            switch character {
            case "a", "i", "j", "q", "y": count += 1
            case "b", "k", "r": count += 2
            case "c", "g", "l", "s": count += 3
            case "d", "m", "t": count += 4
            case "e", "h", "n", "x": count += 5
            case "u", "v", "w": count += 6
            case "o", "z": count += 7
            case "f", "p": count += 8
            default: count += 0
            }
        }
        return count
    }
    
    // функция, с помощью которой получаем разницу между именами в числовом формате ("соответствие")
    private func findResult() -> Int {
        var result = 0
        
        let firstValue = findValue(for: firstName ?? "Error")
        let secondValue = findValue(for: secondName ?? "Error")
        let absDifference = abs(firstValue - secondValue)
        
        switch absDifference {
        case 0, 1, 2: result = 100
        case 3, 4: result = 65
        case 5: result = 50
        case 6: result = 40
        default: result = 30
        }
        return result
    }
}
