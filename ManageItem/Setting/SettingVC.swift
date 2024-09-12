//
//  SettingVC.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Then
import SnapKit
import Toast

class SettingVC: UIViewController {
    
    let vc = MainVC()
    let circleImg = UIImage(systemName: "circle")
    let circleFillImg = UIImage(systemName: "circle.fill")
    let iconImg1 = UIImage(named: "ICON1")
    let iconImg2 = UIImage(named: "ICON2")
    let iconImg3 = UIImage(named: "ICON3")
    
    lazy var infoLabel = UILabel().then {
        $0.text = "설정화면"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    lazy var changeSearchBtn = UIButton().then {
        $0.setTitle("검색버튼으로 변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.backgroundColor = .clear
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        
        if let titleLabel = $0.titleLabel {
            titleLabel.textAlignment = .center
        } else {
            BamYangGang.error("changeSearchBtn의 titleLabel을 찾을 수 없음")
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        $0.configuration = configuration
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
        
        $0.layer.borderColor = UIColor.systemGreen.cgColor
        $0.layer.borderWidth = 2.5
        
        $0.addTarget(self, action: #selector(changeSearchBtnTapped), for: .touchUpInside)
    }
    
    
    lazy var changeAddBtn = UIButton().then {
        $0.setTitle("추가버튼으로 변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.backgroundColor = .clear
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        
        if let titleLabel = $0.titleLabel {
            titleLabel.textAlignment = .center
        } else {
            BamYangGang.error("changeAddBtn의 titleLabel을 찾을 수 없음")
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        $0.configuration = configuration
        
        $0.layer.cornerRadius = 7
        
        $0.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        $0.layer.borderWidth = 2.5
        
        $0.addTarget(self, action: #selector(changeAddBtnTapped), for: .touchUpInside)
    }
    
    lazy var authenticationSwitchView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
        
        $0.layer.borderColor = UIColor.systemPink.withAlphaComponent(0.3).cgColor
        $0.layer.borderWidth = 2.5
    }
    
    lazy var authenticationLabel = UILabel().then {
        $0.text = "인증화면"
        $0.textColor = .black
    }
    
    lazy var authenticationSwitch = UISwitch().then {
        $0.onTintColor = UIColor.systemPink.withAlphaComponent(0.3)
        
        if UserDefaults.standard.string(forKey: "auth") == "on" {
            $0.isOn = true
        } else {
            $0.isOn = false
        }
       
        
        $0.addTarget(self, action: #selector(changeValue), for: .valueChanged)
    }
 
    lazy var selectIconBtn = UIButton().then {
        $0.setTitle("아이콘 변경하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.backgroundColor = .clear
        $0.contentVerticalAlignment = .center
        
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
        
        $0.layer.borderColor = UIColor.systemPink.withAlphaComponent(0.3).cgColor
        $0.layer.borderWidth = 2.5
 
        $0.addTarget(self, action: #selector(selectIconBtnTapped), for: .touchUpInside)
    }
    
    
    
    
    var backgroundBtn: UIButton?
    
    lazy var changeIconBtn1 = UIButton().then {
        $0.tag = 0
        $0.backgroundColor = .clear
        
        $0.addTarget(self, action: #selector(selectAppIcon), for: .touchUpInside)
    }
    
    lazy var iconImageView1 = UIImageView().then {
        $0.image = self.iconImg1
        
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    lazy var changeIconView1 = UIImageView().then {
        $0.image = self.circleImg
        $0.alpha = 1.0
    }
    
    lazy var iconImageView2 = UIImageView().then {
        $0.image = self.iconImg2
        
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    lazy var changeIconBtn2 = UIButton().then {
        $0.tag = 1
        $0.backgroundColor = .clear
        
        $0.addTarget(self, action: #selector(selectAppIcon), for: .touchUpInside)
    }
    
    lazy var changeIconView2 = UIImageView().then {
        $0.image = self.circleImg
    }
    
    lazy var iconImageView3 = UIImageView().then {
        $0.image = self.iconImg3
        
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    lazy var changeIconBtn3 = UIButton().then {
        $0.tag = 2
        $0.backgroundColor = .clear
        
        $0.addTarget(self, action: #selector(selectAppIcon), for: .touchUpInside)
    }
    
    lazy var changeIconView3 = UIImageView().then {
        $0.image = self.circleImg
    }
    
    
    
    



    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "설정"
        self.initSetting()
        
        if UserDefaults.standard.string(forKey: "AppIcon") == nil {
            UserDefaults.standard.setValue("1", forKey: "AppIcon")
            self.changeIconView1.image = self.circleFillImg
        } else if UserDefaults.standard.string(forKey: "AppIcon") == "1" {
            self.changeIconView1.image = self.circleFillImg
            self.changeIconView2.image = self.circleImg
            self.changeIconView3.image = self.circleImg
        } else if UserDefaults.standard.string(forKey: "AppIcon") == "2" {
            self.changeIconView1.image = self.circleImg
            self.changeIconView2.image = self.circleFillImg
            self.changeIconView3.image = self.circleImg
        } else if UserDefaults.standard.string(forKey: "AppIcon") == "3" {
            self.changeIconView1.image = self.circleImg
            self.changeIconView2.image = self.circleImg
            self.changeIconView3.image = self.circleFillImg
        }
    }
    

    // MARK: Func
    func initSetting() {
        
        DispatchQueue.main.async {
            if UserDefaults.standard.string(forKey: "customBtnImageName") == "plus" {
                self.changeSearchBtn.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
                self.changeAddBtn.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                self.changeSearchBtn.layer.borderColor = UIColor.systemGreen.cgColor
                self.changeAddBtn.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
            }
        }
        
    }
    
    
    func changeAppIcon(to iconName: String?) {
        // Build Setting -
        guard UIApplication.shared.supportsAlternateIcons else {
                print("Alternate icons are not supported.")
                return
            }
            
        // 아이콘 변경
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                BamYangGang.error("Error setting icon: \(error.localizedDescription)")
            } else {
                BamYangGang.info("App icon changed successfully.")
            }
        }
    }
    
    
    // MARK: @objc
    @objc func changeSearchBtnTapped() {
        BamYangGang.info("changeSearchBtnTapped")
        
        UserDefaults.standard.setValue("edit", forKey: "move")
        UserDefaults.standard.setValue("magnifyingglass", forKey: "customBtnImageName")
        
        DispatchQueue.main.async {
            if self.changeSearchBtn.layer.borderColor == UIColor.systemGreen.cgColor {
                self.view.makeToast("이미 설정되어 있습니다", duration: 0.5, position: .bottom)
                return
            } else {
                
                self.changeSearchBtn.layer.borderColor = UIColor.systemGreen.cgColor
                self.changeAddBtn.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
                
                self.view.makeToast("설정완료", duration: 0.5, position: .bottom)
            }

        }
        
    }
    
    
    
    
    @objc func changeAddBtnTapped() {
        BamYangGang.info("changeAddBtnTapped")

        UserDefaults.standard.setValue("add", forKey: "move")
        UserDefaults.standard.setValue("plus", forKey: "customBtnImageName")
        
        DispatchQueue.main.async {
            if self.changeAddBtn.layer.borderColor == UIColor.systemGreen.cgColor {
                self.view.makeToast("이미 설정되어 있습니다", duration: 0.5, position: .bottom)
                return
            } else {

                self.changeSearchBtn.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
                self.changeAddBtn.layer.borderColor = UIColor.systemGreen.cgColor
                
                self.view.makeToast("설정완료", duration: 0.5, position: .bottom)
            }
        }
        
    }
    
    @objc func changeValue(_ sender: UISwitch) {
        
        if sender.isOn == true {
            UserDefaults.standard.setValue("on", forKey: "auth")
            self.view.makeToast("설정완료", duration: 0.5, position: .bottom)
        } else {
            UserDefaults.standard.setValue("off", forKey: "auth")
            self.view.makeToast("해제완료", duration: 0.5, position: .bottom)
        }
        
    }
    
    @objc func selectIconBtnTapped(_ sender: UIButton) {
        // check
        if backgroundBtn != nil { return }
        
        
        // Background Btn
        let screenWidth = UIScreen.main.bounds.width   // 화면 너비
        let screenHeight = UIScreen.main.bounds.height // 화면 높이
        
        let backgroundBtn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backgroundBtn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundBtn.alpha = 0
        
        backgroundBtn.addTarget(self, action: #selector(hideView), for: .touchUpInside)
        
        // View
        let newView = UIView()
        newView.backgroundColor = .white
        
        newView.addSubview(self.changeIconBtn1)
        self.changeIconBtn1.snp.makeConstraints {
            $0.width.equalTo(newView.snp.height).multipliedBy(0.5)
            $0.height.equalToSuperview().multipliedBy(0.9)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
       
        
        
        newView.addSubview(self.changeIconBtn2)
        self.changeIconBtn2.snp.makeConstraints {
            $0.width.height.centerY.equalTo(changeIconBtn1)
            $0.leading.equalTo(changeIconBtn1.snp.trailing).offset(10)
        }
        
        newView.addSubview(self.changeIconBtn3)
        self.changeIconBtn3.snp.makeConstraints {
            $0.width.height.centerY.equalTo(changeIconBtn1)
            $0.leading.equalTo(changeIconBtn2.snp.trailing).offset(10)
        }
        
        
        // UIView에 애니메이션 추가 (선택 사항)
        self.view.addSubview(backgroundBtn)
        self.view.bringSubviewToFront(backgroundBtn)
        
        backgroundBtn.addSubview(newView)
        newView.snp.makeConstraints {
            $0.width.centerX.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        
        
        // 애니메이션으로 UIView 표시
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.hidesBackButton = true
            backgroundBtn.alpha = 1.0
        }
        
        
        
        
        
        // 참조를 저장해서 나중에 삭제할 수 있도록 설정
        self.backgroundBtn = backgroundBtn
    }
    
    @objc func hideView() {
        
        self.navigationItem.hidesBackButton = false
        
        if let viewToRemove = self.backgroundBtn {
            
            UIView.animate(withDuration: 0.5) {
                viewToRemove.alpha = 0
            } completion: { _ in
                viewToRemove.removeFromSuperview()
                self.backgroundBtn = nil
            }

            
         
        }
    }
    
    @objc func selectAppIcon(_ sender: UIButton) {
        if sender.tag == 0 {
            if UserDefaults.standard.string(forKey: "AppIcon") == "1" {
                self.customAlert(message: "이미 설정되어 있습니다") { }
                return
            }
            
            UserDefaults.standard.setValue("1", forKey: "AppIcon")
            self.changeIconView1.image = self.circleFillImg
            self.changeIconView2.image = self.circleImg
            self.changeIconView3.image = self.circleImg
            self.changeAppIcon(to: nil)
            self.hideView()
            
        } else if sender.tag == 1 {
            if UserDefaults.standard.string(forKey: "AppIcon") == "2" {
                self.customAlert(message: "이미 설정되어 있습니다") { }
                return
            }
            
            UserDefaults.standard.setValue("2", forKey: "AppIcon")
            self.changeIconView1.image = self.circleImg
            self.changeIconView2.image = self.circleFillImg
            self.changeIconView3.image = self.circleImg
            self.changeAppIcon(to: "AppIcon_1")
            self.hideView()
        } else if sender.tag == 2 {
            if UserDefaults.standard.string(forKey: "AppIcon") == "3" {
                self.customAlert(message: "이미 설정되어 있습니다") { }
                return
            }
            
            UserDefaults.standard.setValue("3", forKey: "AppIcon")
            self.changeIconView1.image = self.circleImg
            self.changeIconView2.image = self.circleImg
            self.changeIconView3.image = self.circleFillImg
            self.changeAppIcon(to: "AppIcon_2")
            self.hideView()
        }
    }
    
    
    
// MARK: End
    
}

// MARK: End



