//
//  UILabel+.swift
//  ManageItem
//
//  Created by 김성호 on 9/4/24.
//

import UIKit

extension UILabel {
    // DS: Default Setting

    func addVC_DS(text: String) {
        self.text = text
        self.textColor = UIColor.black
    }
    
}

class PaddedLabel: UILabel {

    var textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
}

