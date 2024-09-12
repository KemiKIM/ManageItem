//
//  UIViewController+.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit

extension UIViewController {

    func moveToOtherVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
