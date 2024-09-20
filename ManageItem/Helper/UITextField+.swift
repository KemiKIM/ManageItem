//
//  UITextField+.swift
//  ManageItem
//
//  Created by 김성호 on 9/20/24.
//

import UIKit

extension UITextField {
    // DS: Default Setting
    
    func addVC_DS(height: CGFloat) {
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray2.cgColor
        
        self.layer.cornerRadius = 4
        
        self.borderStyle = .roundedRect
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
