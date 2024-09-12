//
//  SettingVC+Layout.swift
//  ManageItem
//
//  Created by 김성호 on 9/3/24.
//

import UIKit
import SnapKit

extension SettingVC {
    
    func layout() {
        self.view.backgroundColor = .white
        
        configureInfoLabel()
        
        configureChangeSearchBtn()
        configureChangeAddBtn()
        
        configureAuthenticationSwitchView()
        configureAuthenticationLabel()
        configureAuthenticationSwitch()
        
        configureSelectIconBtn()
        
        //
        configureSelectIconView1()
        configureSelectIconView2()
        configureSelectIconView3()
    }
    
    func configureInfoLabel() {
        self.view.addSubview(self.infoLabel)
        
        self.infoLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.15)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    func configureChangeSearchBtn() {
        self.view.addSubview(self.changeSearchBtn)
        
        self.changeSearchBtn.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalTo(self.infoLabel)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.top.equalTo(self.infoLabel.snp.bottom)
        }
    }
    
    
    func configureChangeAddBtn() {
        self.view.addSubview(self.changeAddBtn)
        
        self.changeAddBtn.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalTo(self.infoLabel)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.top.equalTo(self.changeSearchBtn.snp.bottom).offset(20)
        }
    }
    
    func configureAuthenticationSwitchView() {
        self.view.addSubview(self.authenticationSwitchView)
        
        self.authenticationSwitchView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalTo(self.infoLabel)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.top.equalTo(self.changeAddBtn.snp.bottom).offset(20)
        }
    }
    
    func configureAuthenticationLabel() {
        self.authenticationSwitchView.addSubview(self.authenticationLabel)
        
        self.authenticationLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    func configureAuthenticationSwitch() {
        self.authenticationSwitchView.addSubview(self.authenticationSwitch)
        
        self.authenticationSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    func configureSelectIconBtn() {
        self.view.addSubview(self.selectIconBtn)

        self.selectIconBtn.snp.makeConstraints {
            $0.width.height.centerX.equalTo(self.changeSearchBtn)
            $0.top.equalTo(self.authenticationSwitchView.snp.bottom).offset(20)
        }
    }
    
    func configureSelectIconView1() {
        self.changeIconBtn1.addSubview(self.iconImageView1)
        self.iconImageView1.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(self.iconImageView1.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        self.changeIconBtn1.addSubview(self.changeIconView1)
        self.changeIconView1.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.iconImageView1.snp.bottom).offset(15)
        }
    }
    
    func configureSelectIconView2() {
        self.changeIconBtn2.addSubview(self.iconImageView2)
        self.iconImageView2.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(self.iconImageView2.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        self.changeIconBtn2.addSubview(self.changeIconView2)
        self.changeIconView2.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.iconImageView2.snp.bottom).offset(15)
        }
    }
    
    func configureSelectIconView3() {
        self.changeIconBtn3.addSubview(self.iconImageView3)
        self.iconImageView3.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(self.iconImageView3.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        self.changeIconBtn3.addSubview(self.changeIconView3)
        self.changeIconView3.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.iconImageView3.snp.bottom).offset(15)
        }
    }
    
    
}

