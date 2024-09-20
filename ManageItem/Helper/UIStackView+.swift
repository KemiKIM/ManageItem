//
//  UIStackView+.swift
//  ManageItem
//
//  Created by 김성호 on 9/20/24.
//

import UIKit

extension UIStackView {
    // DS: Default Setting
    
    func addVC_DS(distribution: UIStackView.Distribution,
               spacing: CGFloat?,
               labelArr: [UIView]) {
        
        self.axis = .vertical
        self.distribution = distribution
        
        if let spacing = spacing {
            self.spacing = spacing
        }
        
        for i in labelArr {
            self.addArrangedSubview(i)
        }
    }
    
}
