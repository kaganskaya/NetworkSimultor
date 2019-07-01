//
//  StorageService.swift
//  NetworkSimulator
//
//  Created by liza_kaganskaya on 6/30/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import CoreData

class StorageService{
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NetworkSimulator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveCar(cars: [Cars]) {
        self.deleteData()
        for item in cars {
            saveCarInfoToBd(car:item)
        }
    }
    
    private func saveCarInfoToBd(car:Cars){
        
        do {
            
            let entityCar =  NSEntityDescription.entity(forEntityName: "Car",in: context)!
            let bdCar = NSManagedObject(entity: entityCar,insertInto: context) as! Car
            
            let entityOwner =  NSEntityDescription.entity(forEntityName: "CarOwner",in: context)!
            let owner = NSManagedObject(entity: entityOwner,insertInto: context) as! CarOwner
            
            for item in car.owners{
                owner.name = item.ownerName
                owner.phone = item.ownerPhone
                owner.ownerID = Int16(item.ownerID)
            }
            
            bdCar.id = Int16(car.carID)
            bdCar.model = car.carModel
            bdCar.color = car.carColor
            bdCar.type = car.carType
            bdCar.hasOwner = owner
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getCarsInfoFromBd() -> [Car]{
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        var cars:[Car?] = []
        do {
            cars  = try (self.context.fetch(fetchRequest) as! [Car])
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return cars as! [Car]
    }
    
    private func deleteData(){
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        let fetchRequest1 =  NSFetchRequest<NSFetchRequestResult>(entityName: "CarOwner")
        
        do {
            let fetchedResults =  try context.fetch(fetchRequest)
            let fetchedResults1 =  try context.fetch(fetchRequest1)
        
            for entity in fetchedResults {
                context.delete(entity as! NSManagedObject)
            }
        
            for entity in fetchedResults1 {
                context.delete(entity as! NSManagedObject)
            }
            
            do{
                try context.save()
            } catch let error as NSError {
                print(error)
            }
            
        }catch let error as NSError {
            print("Detele all my data in error : \(error) \(error.userInfo)")
        }
    }
}
