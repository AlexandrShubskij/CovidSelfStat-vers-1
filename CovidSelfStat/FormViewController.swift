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
    
    let dataAndTime = RealDataAndTime()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        fullForm.time = dataAndTime.realTime()
        fullForm.date = dataAndTime.realDate()
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
