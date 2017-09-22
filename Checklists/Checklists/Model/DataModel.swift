//
//  DataModel.swift
//  Checklists
//
//  Created by elliot xin on 9/22/17.
//  Copyright © 2017 elliot xin. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
    }
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists(){
        
        let data = NSMutableData()
        let archive = NSKeyedArchiver(forWritingWith: data)
        
        archive.encode(lists, forKey: "Checklists")
        archive.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        
        let path = dataFilePath()
        if let data =  try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            unarchiver.finishDecoding()
        }
    }
}
