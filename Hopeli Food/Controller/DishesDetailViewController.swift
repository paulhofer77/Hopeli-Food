//
//  DishesDetailViewController.swift
//  Hopeli Food
//
//  Created by Paul Hofer on 01.09.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit
import RealmSwift

class DishesDetailViewController: UIViewController {

    let realm = try! Realm()
    
    var selectedDish: Dishes? {
        didSet {
//            loadDishesData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        title = selectedDish?.dishName
    }

}
