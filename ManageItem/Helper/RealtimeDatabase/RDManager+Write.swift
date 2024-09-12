//
//  RDManager+Write.swift
//  ManageItem
//
//  Created by 김성호 on 9/6/24.
//

import Foundation
import FirebaseDatabase

extension RDManager {
    
    func setItem(withId id: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        ref.child("users").child(id).setValue(data) { error, _ in
            completion(error)
        }
    }
        
    func updateItem(arrayIndex: Int, name: String, partName: String, partNumber: String, location: String, completion: @escaping (Error?) -> Void) {

        let updateData: [String: Any] = [
            "name": name,
            "partName": partName,
            "partNumber": partNumber,
            "location": location
        ]
        
        
        if UserDefaults.standard.string(forKey: "realtimedatabase") == "test" {
            
            // test
            self.ref.child("/test/\(arrayIndex)").updateChildValues(updateData) { error, _ in
                if let error = error {
                    print("데이터 업데이트 실패: \(error.localizedDescription)")
                } else {
                    print("데이터 업데이트 성공")
                    completion(nil)
                }
            }
        } else {
            self.ref.child("/allitems/\(arrayIndex)").updateChildValues(updateData) { error, _ in
                if let error = error {
                    print("데이터 업데이트 실패: \(error.localizedDescription)")
                } else {
                    print("데이터 업데이트 성공")
                    completion(nil)
                }
            }
        }
        
        
    }
    
    
}
