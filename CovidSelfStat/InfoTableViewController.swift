//
//  InfoTableViewController.swift
//  CovidSelfStat
//
//  Created by Александр Шубский on 27.11.2020.
//

import UIKit
import RealmSwift

class InfoTableViewController: UITableViewController {

    var statistic: Results<FormModel>!
    let realm = try! Realm()
    
    let dataAndTime = RealDataAndTime()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statistic.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statistic", for: indexPath) as? StatViewCell
        
        let today = dataAndTime.realDate()
        let yesterday = dataAndTime.yesterdayDate()
        
        
        
        let info: [FormModel] = Array(statistic.reversed())
        let cellStat = info[indexPath.row]

        switch cellStat.date{
        case today:
            cell?.dateLabel.text = "Сегодня"
        case yesterday:
            cell?.dateLabel.text = "Вчера"
        default:
            cell?.dateLabel.text = cellStat.date
        }
        
        cell?.timeLabel.text = cellStat.time
        cell?.temperatureLabel.text = cellStat.temperature
        cell?.saturationLabel.text = cellStat.saturation
        cell?.pulseLabel.text = cellStat.pulse
        cell?.chssLabel.text = cellStat.chss
        
        return cell!
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statistic = realm.objects(FormModel.self)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
