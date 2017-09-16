//
//  ChecklistItem.swift
//  Checklists
//
//  Created by elliot xin on 9/13/17.
//  Copyright © 2017 elliot xin. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject{
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
