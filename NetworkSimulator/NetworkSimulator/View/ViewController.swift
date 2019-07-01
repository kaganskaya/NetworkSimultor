//
//  ViewController.swift
//  NetworkSimulator
//
//  Created by liza_kaganskaya on 6/30/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBAction func refrechButton(_ sender: UIButton) {
        presenter.loadData()
    }
    
    let presenter = Presenter()
    var cars:[Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.loadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
}

extension ViewController: MainView {
    func showCars(cars: [Car]) {
        self.cars = cars
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TableViewCell
        cell.label.text = self.cars[indexPath.row].model        
        return cell
    }
    
    
    
}

