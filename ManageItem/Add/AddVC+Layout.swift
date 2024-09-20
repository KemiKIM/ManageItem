//
//  AddVC+Layout.swift
//  ManageItem
//
//  Created by 김성호 on 9/20/24.
//

import UIKit
import SnapKit

extension AddVC {
    
    func layout() {
        self.view.backgroundColor = .white
        
        configureBackgroundView()
        configureLabelStackView()
        configureTextFieldStackView()
        
        configureConfirmBtn()
    }
    
    private func configureBackgroundView() {
        self.view.addSubview(self.backgroundView)
        
        self.backgroundView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    private func configureLabelStackView() {
        self.backgroundView.addSubview(self.labelStackView)
        
        self.labelStackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    private func configureTextFieldStackView() {
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
    
    private func configureConfirmBtn() {
        self.view.addSubview(self.confirmBtn)
        
        self.confirmBtn.snp.makeConstraints {
            $0.width.equalTo(self.backgroundView)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.backgroundView.snp.bottom).offset(30)
        }
    }
    
    
}

