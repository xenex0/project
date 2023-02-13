//
//  Model.swift
//  projectHolodez
//
//  Created by Дмитрий Абдуллаев on 21.01.2023.
//

import Foundation

class Man: NSObject, NSCoding {
   var name: String
    
    init(name: String) {
     self.name = name
    }
    func encode(with coder: NSCoder) {
     coder.encode(name, forKey: "name")
    }
    
    required init?(coder: NSCoder) {
     name = coder.decodeObject(forKey: "name") as? String ?? ""
    }
}

