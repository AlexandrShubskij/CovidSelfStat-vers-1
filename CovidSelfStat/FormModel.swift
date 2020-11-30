//
//  FormModel.swift
//  CovidSelfStat
//
//  Created by Александр Шубский on 27.11.2020.
//

import Foundation
import UIKit
import RealmSwift

class FormModel: Object {
    @objc dynamic var time: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var temperature: String = ""
    @objc dynamic var saturation: String = ""
    @objc dynamic var pulse: String = ""
    @objc dynamic var chss: String = ""
}
