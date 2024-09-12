//
//  MainVC+Layout.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import SnapKit

// MARK: [ Layout ]
extension MainVC {
    
    func layout() {
        self.view.backgroundColor = .white
        
        configureSerachBar()
        configureDivisionView()
        configureDivisionStackView()
        
        configureMainTableView()
        configureCustomRefreshControl()
        
        configureCustomBtn()
    }
    
    private func configureSerachBar() {
        self.searchBar.inputAccessoryView = self.keyboardToolBar
        
        self.view.addSubview(self.searchBar)
        
        self.searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
    
    private func configureDivisionView() {
        self.view.addSubview(self.divisionView)
        
        self.divisionView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    private func configureDivisionStackView() {
        self.divisionView.addSubview(self.divisionStackView)
        
        self.divisionStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureMainTableView() {
        self.view.addSubview(self.mainTableView)
        
        self.mainTableView.snp.makeConstraints {
            $0.top.equalTo(self.divisionView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureCustomRefreshControl() {
        self.refreshControl.addSubview(self.refreshImg)
        
        self.refreshImg.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.center.equalToSuperview()
        }
    }
    
    private func configureCustomBtn() {
        self.view.addSubview(self.customBtn)
        self.view.bringSubviewToFront(self.customBtn)
        
        self.customBtn.snp.makeConstraints {
            $0.width.height.equalTo(55)
            $0.trailing.equalTo(self.mainTableView.snp.trailing).offset(-20)
            $0.bottom.equalTo(self.mainTableView.snp.bottom).offset(-60)
        }
       
    }
}
