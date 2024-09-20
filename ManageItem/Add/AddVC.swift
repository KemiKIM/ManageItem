//
//  AddVC.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Then
import SnapKit

class AddVC: UIViewController {
    
    var index: Int = 0
    var message: String = ""
    
    lazy var backgroundView = UIView()
    
    lazy var nameLabel = UILabel().then {
        $0.addVC_DS(text: "장비명: ")
    }
    
    lazy var partNameLabel = UILabel().then {
        $0.addVC_DS(text: "부품명: ")
    }

    lazy var partNumberLabel = UILabel().then {
        $0.addVC_DS(text: "파트번호: ")
    }
    
    lazy var locationLabel = UILabel().then {
        $0.addVC_DS(text: "위치: ")
    }
    
    lazy var labelArr = [nameLabel, partNameLabel, partNumberLabel, locationLabel]
    
    lazy var labelStackView = UIStackView().then {
        $0.addVC_DS(distribution: .equalSpacing,
                 spacing: nil,
                 labelArr: labelArr)
    }
    
    
    lazy var nameTextField = UITextField().then {
        $0.addVC_DS(height: $0.frame.height)
    }
    
    lazy var partNameTextField = UITextField().then {
        $0.addVC_DS(height: $0.frame.height)
    }
    
    lazy var partNumberTextField = UITextField().then {
        $0.addVC_DS(height: $0.frame.height)
    }
    
    lazy var locationTextField = UITextField().then {
        $0.addVC_DS(height: $0.frame.height)
    }
    
    lazy var tfArr = [nameTextField, partNameTextField, partNumberTextField, locationTextField]
    
    lazy var textFieldStackView = UIStackView().then {
        $0.addVC_DS(distribution: .fillEqually,
                 spacing: 5,
                 labelArr: tfArr)
    }
    
    
    lazy var keyboardToolBar = UIToolbar().then {
        $0.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(keyboardDown))
        doneButton.tintColor = UIColor.lightPink
        
        $0.items = [flexSpace, doneButton]
    }
    
    lazy var confirmBtn = UIButton().then {
        $0.backgroundColor = UIColor.lightPink
        
        $0.setTitleColor(.white, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        
        $0.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "자재 추가"
        
        if UserDefaults.standard.string(forKey: "move") == "edit" {
            self.confirmBtn.setTitle("수정하기", for: .normal)
            self.message = "수정이 완료되었습니다."
        } else {
            self.confirmBtn.setTitle("추가하기", for: .normal)
            self.message = "추가가 완료되었습니다."
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // init
        for textField in tfArr {
            textField.text = nil
        }
        
        self.index = 0
        self.confirmBtn.setTitle(nil, for: .normal)
    }
    
    
    
    
    // MARK: Function
    func receiveText(index: Int, currentItem: ItemModel) {
        self.index = index
        
        self.nameTextField.text = currentItem.name
        self.partNameTextField.text = currentItem.partName
        self.partNumberTextField.text = currentItem.partNumber
        self.locationTextField.text = currentItem.location
    }
    
    
    
    
    // MARK: @objc
    @objc func keyboardDown() {
        for textField in tfArr {
            textField.resignFirstResponder()
        }
    }
    
    @objc func confirmTapped(_ sender: UIButton) {
        let name = self.nameTextField.text ?? ""
        let partName = self.partNameTextField.text ?? ""
        let partNumber = self.partNumberTextField.text ?? ""
        let location = self.locationTextField.text ?? ""
        
        
        RDManager.shared.updateItem(arrayIndex: self.index,
                                    name: name,
                                    partName: partName,
                                    partNumber: partNumber,
                                    location: location) { error in
            
            
            self.customAlert(message: self.message) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
}


