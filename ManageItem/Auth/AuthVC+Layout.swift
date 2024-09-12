//
//  AuthVC+Layout.swift
//  ManageItem
//
//  Created by 김성호 on 9/4/24.
//

import UIKit
import SnapKit

extension AuthVC {
    
    func layout() {
        self.view.backgroundColor = .white
        
        configureAuthTextField()
        configureAuthLabel()
        
        configureExperienceBtn()
    }
    
    private func configureAuthTextField() {
        self.view.addSubview(self.authTextField)
        
        self.authTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalToSuperview().multipliedBy(0.07)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureAuthLabel() {
        self.view.addSubview(self.authLabel)
        
        self.authLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalToSuperview().multipliedBy(0.07)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.authTextField.snp.top)
        }
    }
    
    private func configureExperienceBtn() {
        self.view.addSubview(self.experienceBtn)
        
        self.experienceBtn.snp.makeConstraints {
            $0.width.height.centerX.equalTo(self.authTextField)
            $0.top.equalTo(self.authTextField.snp.bottom).offset(20)
        }
    }
}

