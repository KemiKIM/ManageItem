//
//  ItemModel.swift
//  ManageItem
//
//  Created by 김성호 on 9/5/24.
//

struct ItemModel {
    let name: String
    let partName: String
    let partNumber: String
    let location: String
    
    // Dictionary에서 모델로 변환할 초기화 메서드
    init?(from dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let partName = dictionary["partName"] as? String,
            let partNumber = dictionary["partNumber"] as? String,
            let location = dictionary["location"] as? String
        else {
            return nil
        }
        
        self.name = name
        self.partName = partName
        self.partNumber = partNumber
        self.location = location
    }
}

