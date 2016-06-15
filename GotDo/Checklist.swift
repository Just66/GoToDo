//
//  Checklist.swift
//  GotDo
//
//  Created by Dmytro Aprelenko on 16.03.16.
//  Copyright © 2016 Dmytro Aprelenko. All rights reserved.
//

import UIKit


class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    var icon: String
        
    convenience init(name: String) {
        self.init(name: name, icon: "No Icon")
    }
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
        
        super.init()
    }
        required init?(coder aDecoder: NSCoder) {
            name = aDecoder.decodeObjectForKey("Name") as! String
            items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
            icon = aDecoder.decodeObjectForKey("Icon") as! String
        
            super.init()
        }
        func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(name, forKey: "Name")
            aCoder.encodeObject(items, forKey: "Items")
            aCoder.encodeObject(icon, forKey: "Icon")
            
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
    
    
    }


