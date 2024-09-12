//
//  AddVC.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Then
import SnapKit
import Toast

class AddVC: UIViewController {
    
    var index: Int = 0
    var message: String = ""
    
    
    
    lazy var backgroundView = UIView()
    
    lazy var nameLabel = UILabel().then {
        $0.text = "장비명: "
        $0.textColor = .black
    }
    lazy var partNameLabel = UILabel().then {
        $0.text = "부품명: "
        $0.textColor = .black
    }

    lazy var partNumberLabel = UILabel().then {
        $0.text = "파트번호: "
        $0.textColor = .black
    }
    lazy var locationLabel = UILabel().then {
        $0.text = "위치: "
        $0.textColor = .black
    }
    
    lazy var labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(partNameLabel)
        $0.addArrangedSubview(partNumberLabel)
        $0.addArrangedSubview(locationLabel)
    }
    
    
    lazy var nameTextField = UITextField().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        
        $0.layer.cornerRadius = 4
        
        $0.borderStyle = .roundedRect
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    lazy var partNameTextField = UITextField().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        
        $0.layer.cornerRadius = 4
        
        $0.borderStyle = .roundedRect
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    lazy var partNumberTextField = UITextField().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        
        $0.layer.cornerRadius = 4
        
        $0.borderStyle = .roundedRect
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    lazy var locationTextField = UITextField().then {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        
        $0.layer.cornerRadius = 4
        
        $0.borderStyle = .roundedRect
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    lazy var textFieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        
        $0.spacing = 5
        
        $0.addArrangedSubview(nameTextField)
        $0.addArrangedSubview(partNameTextField)
        $0.addArrangedSubview(partNumberTextField)
        $0.addArrangedSubview(locationTextField)
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
        self.nameTextField.text = nil
        self.partNameTextField.text = nil
        self.partNumberTextField.text = nil
        self.locationTextField.text = nil
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
    
    
    
    
    @objc func keyboardDown() {
        self.nameTextField.resignFirstResponder()
        self.partNameTextField.resignFirstResponder()
        self.partNumberTextField.resignFirstResponder()
        self.locationTextField.resignFirstResponder()
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


extension AddVC {
    
    func layout() {
        self.view.backgroundColor = .white
        
        configureBackgroundView()
        configureLabelStackView()
        configureTextFieldStackView()
        
        configureConfirmBtn()
    }
    
    func configureBackgroundView() {
        self.view.addSubview(self.backgroundView)
        
        self.backgroundView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    func configureLabelStackView() {
        self.backgroundView.addSubview(self.labelStackView)
        
        self.labelStackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func configureTextFieldStackView() {
        self.nameTextField.inputAccessoryView = self.keyboardToolBar
        self.partNameTextField.inputAccessoryView = self.keyboardToolBar
        self.partNumberTextField.inputAccessoryView = self.keyboardToolBar
        self.locationTextField.inputAccessoryView = self.keyboardToolBar
        
        self.backgroundView.addSubview(self.textFieldStackView)
        
        self.textFieldStackView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    func configureConfirmBtn() {
        self.view.addSubview(self.confirmBtn)
        
        self.confirmBtn.snp.makeConstraints {
            $0.width.equalTo(self.backgroundView)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.backgroundView.snp.bottom).offset(30)
        }
    }
    
    
}
