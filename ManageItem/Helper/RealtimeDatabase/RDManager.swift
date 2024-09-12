//
//  RDManager.swift
//  ManageItem
//
//  Created by 김성호 on 9/3/24.
//

import Foundation
import FirebaseDatabase

class RDManager {
    static let shared = RDManager()
    
    let ref: DatabaseReference
    
    private init() {
        ref = Database.database().reference()
    }
    
}
