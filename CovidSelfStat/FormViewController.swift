//
//  FormViewController.swift
//  CovidSelfStat
//
//  Created by Александр Шубский on 27.11.2020.
//

import UIKit
import RealmSwift

class FormViewController: UIViewController {
    
    @IBOutlet weak var tempTextField: UITextField!
    @IBOutlet weak var saturationTextField: UITextField!
    @IBOutlet weak var pulseTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    let realm = try! Realm()
    var fullForm = FormModel()
    
    let table = InfoTableViewController()
    
    func realTime() -> String {
        var finalHour: String
        var finalMinute: String
        var finalSecond: String
        
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        if hour < 10 {
            finalHour = "0" + String(hour)
        } else {
            finalHour = String(hour)
        }
        if minute < 10 {
            finalMinute = "0" + String(minute)
        } else {
            finalMinute = String(minute)
        }
        if second < 10 {
            finalSecond = "0" + String(second)
        } else {
            finalSecond = String(second)
        }
        
        let time = "\(finalHour):\(finalMinute):\(finalSecond)"
        print(time)
        return time
    }
    
    func realDate() -> String{
        var finalDay: String
        var finalMonth: String
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        if day < 10 {
            finalDay = "0" + String(day)
        } else {
            finalDay = String(day)
        }
        if month < 10 {
            finalMonth = "0" + String(month)
        } else {
            finalMonth = String(month)
        }
        
        let finalDate = "\(finalDay).\(finalMonth).\(year)"
        
        print(finalDate)
        return finalDate
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        fullForm.time = realTime()
        fullForm.date = realDate()
        fullForm.temperature = tempTextField.text ?? "Не заполнено"
        fullForm.saturation = saturationTextField.text ?? "Не заполнено"
        fullForm.pulse = pulseTextField.text ?? "Не заполнено"
        
        if timeTextField.text == nil {
            fullForm.chss = "Не заполнено"
        } else {
            var timer = Double(timeTextField.text!)
            guard timer != nil else {
                timer = 1
                return
            }
            let chss = 15 / timer! * 60
            fullForm.chss = String(format: "%.2f", chss)
            
        }
        
        try! self.realm.write {
            print(fullForm)
            self.realm.add(self.fullForm)
            
            table.tableView.reloadData()
            self.realm.refresh()
        }
        
        table.tableView.reloadData()
        
    }
    
    
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
