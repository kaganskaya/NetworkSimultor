//
//  Presenter.swift
//  NetworkSimulator
//
//  Created by liza_kaganskaya on 6/30/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

class Presenter {
    
    let networkService = NetworkService()
    let storageService = StorageService()
    weak var view: MainView?

    func loadData(){
        if networkService.checkInternet() {
            networkService.getData(fileName: "cars", completion: {cars in
                storageService.saveCar(cars: cars)
            })
        }        
        let result = storageService.getCarsInfoFromBd()
        self.view!.showCars(cars: result)
    }
}
