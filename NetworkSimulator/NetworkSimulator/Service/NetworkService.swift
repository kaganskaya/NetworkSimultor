//
//  NetworkService.swift
//  NetworkSimulator
//
//  Created by liza_kaganskaya on 6/30/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    
    func getData(fileName:String,completion:([Cars]) -> () ){
        
        let decoder = JSONDecoder()
        var content:[Cars] = []
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                content = try decoder.decode([Cars].self, from: data)
                
            }catch let error as NSError{
                print(error)
            }
        }
        completion(content)
    }
    
    func checkInternet() -> Bool {
        
        let interent =  NetworkReachabilityManager()!.isReachable ? true : false
        return interent
    }
    
}


