//
//  ViewController.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Then
import SnapKit
import Toast
import FirebaseDatabase
import Lottie

class MainVC: UIViewController {
    
    private var animationView: LottieAnimationView?
    
    var allItems: [ItemModel] = []
    var filteredItems: [ItemModel] = []
    
    var isSearching = false
    
    
    lazy var searchBar = UISearchBar().then {
        $0.backgroundColor = .white
        $0.barTintColor = .white
        $0.backgroundImage = UIImage()
        $0.searchTextField.backgroundColor = .systemGray5
        
        $0.delegate = self
        
        $0.sizeToFit()
        $0.placeholder = " 검색"
        
        $0.keyboardType = .default
    }
    
    lazy var keyboardToolBar = UIToolbar().then {
        $0.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(keyboardDown))
        doneButton.tintColor = UIColor.lightPink
        
        $0.items = [flexSpace, doneButton]
    }
    
    lazy var divisionView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.05)
    }
    
    lazy var divisionLabel1 = PaddedLabel().then {
        $0.text = "장비명"
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel2 = PaddedLabel().then {
        $0.text = "부품명"
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel3 = PaddedLabel().then {
        $0.text = "파트번호"
        $0.textColor = .black
        $0.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    lazy var divisionLabel4 = PaddedLabel().then {
        $0.text = "위치"
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
    
    
    lazy var refreshControl = UIRefreshControl().then {
        $0.tintColor = .clear
        $0.backgroundColor = .white
        
        $0.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    lazy var refreshImgBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var refreshImg = UIImageView().then {
        let img = UIImage(named: "dogfoot")
        $0.image = img
        
        $0.contentMode = .scaleAspectFit
    }
    
    
    lazy var mainTableView = UITableView().then {
        $0.backgroundColor = .white
        
        $0.dataSource = self
        $0.delegate = self
        $0.register(ItemTVC.self, forCellReuseIdentifier: ItemTVC.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = 0
        
        $0.refreshControl = refreshControl
    }
    

    
    lazy var customBtn = UIButton().then {
        $0.backgroundColor = UIColor.lightPink
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        
        $0.tintColor = .white
    }
    
    
    
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSetting {
            self.startSetting()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "자재관리"
        
        self.setCustomBtnAction()
        
        self.initSetting {
            self.searchBar.text = ""
            self.filteredItems = self.allItems
            self.mainTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: Function
    func initSetting(completion: @escaping () -> Void) {
        // Lottie Set
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView = LottieManager.shared.createLottieAnimationView(name: "dog", frame: frame)
        
        
        // Lottie Start
        LottieManager.shared.startAnimation(view: self.view, animationView: animationView) {
            self.customAlert(message: "Lottie 설정실패") {}
        }
       
        
        // Firebase Realtime Database
        RDManager.shared.readAllItems { value in
            if let animationView = self.animationView {
                // Lottie Stop
                LottieManager.shared.stopAnimation(animationView: animationView)
            }
            if let value = value as? [[String:Any]] {
                self.allItems = value.compactMap { ItemModel(from: $0) }
                completion()
            }
        }
        
    }
    
    
    func startSetting() {
        self.setNaviBar()
        self.layout()
    }
    
    
    func setNaviBar() {
        
        // title Color
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        // Back
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = UIColor.lightPink  // 색상 변경
        self.navigationItem.backBarButtonItem = backButton
        
        // Left
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(toSettingVC))
        leftButton.tintColor = UIColor.lightPink
        self.navigationItem.leftBarButtonItem = leftButton
        
        // Right
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toAddVC))
        rightButton.tintColor = UIColor.lightPink
        // ---- 추후 지원
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func setCustomBtnAction() {
        // init
        self.customBtn.removeTarget(nil, action: nil, for: .allEvents)
        
        if UserDefaults.standard.string(forKey: "customBtnImageName") == "plus" {
            let iconImage = UIImage(systemName: "plus")
            DispatchQueue.main.async {
                self.customBtn.setImage(iconImage, for: .normal)
            }
            self.customBtn.addTarget(self, action: #selector(toAddVC), for: .touchUpInside)
            
        } else {
            let iconImage = UIImage(systemName: "magnifyingglass")
            DispatchQueue.main.async {
                self.customBtn.setImage(iconImage, for: .normal)
            }
            self.customBtn.addTarget(self, action: #selector(keyboardUp), for: .touchUpInside)
        }
        
    }
    
    

    
    // MARK: @objc
    @objc func toSettingVC() {
        self.moveToOtherVC(vc: SettingVC())
    }
    
    @objc func toAddVC() {
        let index = self.allItems.count
        UserDefaults.standard.setValue("add", forKey: "move")
        let add = AddVC()
        add.index = index
        self.moveToOtherVC(vc: add)
    }
    
    @objc func keyboardDown() {
        self.searchBar.resignFirstResponder()
    }
    
    @objc func keyboardUp() {
        self.searchBar.becomeFirstResponder()
    }
    
    @objc func refreshTableView(_ sender: UIRefreshControl) {
        self.initSetting {
            self.mainTableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    
// MARK: End
    
}

// MARK: End


