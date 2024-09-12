//
//  RDManager+Read.swift
//  ManageItem
//
//  Created by 김성호 on 9/3/24.
//

import Foundation
import FirebaseDatabase

extension RDManager {
    
    func readAllItems(completion: @escaping (Any) -> ()) {
        
        ref.child("/").observe(.value) { snapshot in
            
            if let value = snapshot.value as? [String: Any] {
                BamYangGang.info("All Data Read Success")
                
                
               
                if UserDefaults.standard.string(forKey: "realtimedatabase") == "test" {
                    // test
                    if let allitems = value["test"] {
                        completion(allitems)
                    }
                } else {
                    if let allitems = value["allitems"] {
                        completion(allitems)
                    }
                }
                
           
              
            } else {
                // Fail Read
                BamYangGang.error("데이터가 존재하지 않음")
                return
            }
        }
        
        
    }
    
}
