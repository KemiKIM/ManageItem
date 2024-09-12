//
//  ItemTVC.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Then
import SnapKit

class ItemTVC: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    lazy var divisionView = UIView()
    
    lazy var divisionLabel1 = PaddedLabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel2 = PaddedLabel().then {
        $0.backgroundColor = .systemGray6
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel3 = PaddedLabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel4 = PaddedLabel().then {
        $0.backgroundColor = .systemGray6
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    
    lazy var divisionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        
        $0.addArrangedSubview(divisionLabel1)
        $0.addArrangedSubview(divisionLabel2)
        $0.addArrangedSubview(divisionLabel3)
        $0.addArrangedSubview(divisionLabel4)
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    private func layout() {
        self.contentView.addSubview(self.divisionView)
        self.divisionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.divisionView.addSubview(self.divisionStackView)
        self.divisionStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
 
    
    
    
    
}
