//
//  UIAlert+.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit

extension UIViewController {
    
    func customAlert(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    func customAlert2(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    func selectAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let action = UIAlertAction(title: "편집", style: .default) { _ in
            completion()
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    
}
