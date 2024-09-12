//
//  AuthVC.swift
//  ManageItem
//
//  Created by 김성호 on 9/4/24.
//

import UIKit
import Then
import SnapKit

class AuthVC: UIViewController {
    
    
    lazy var authLabel = UILabel().then {
        $0.text = "인증코드 입력"
        $0.textColor = .black
        
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    lazy var authTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "인증코드 입력"
        $0.keyboardType = .numberPad // 숫자 키패드 설정

        $0.autocorrectionType = .no // 자동 수정 기능 비활성화
        $0.autocapitalizationType = .none // 대문자 자동 변환 비활성화
        $0.isSecureTextEntry = true // 글자 보안
        
        $0.delegate = self
    }
    
    lazy var experienceBtn = UIButton().then {
        $0.setTitle("체험하기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.backgroundColor = .systemGray5
        $0.contentVerticalAlignment = .center
        
        $0.layer.cornerRadius = 7
        
        $0.addTarget(self, action: #selector(moveToMainVC), for: .touchUpInside)
    }
    
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "auth") == "on" {
            self.layout()
            self.setupTapGesture()
            self.authTextField.becomeFirstResponder()
        } else {
            self.moveToMain()
        }
        
    }
    
    
    
    
    // MARK: Function
    private func setupTapGesture() {
        // 빈 화면 클릭 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func inputComplete() {
        
        if var text = authTextField.text {
            if text == "01022039321" || text == "01051108877" {
                // Success
                self.moveToMain()
                
            } else {
                self.customAlert(message: "유효한 인증코드가 아닙니다") {}
                return
            }
            
        } else {
            self.customAlert(message: "텍스트를 정상적으로 받아올 수 없습니다") {}
            return
        }
        

    }
    
    private func moveToMain() {
        DispatchQueue.main.async {
            let vc = MainVC()
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.modalTransitionStyle = .crossDissolve
            self.present(navigationController, animated: true)
        }
    }
    
    
    
    // MARK: @objc
    @objc private func dismissKeyboard() {
        self.view.endEditing(true) // 모든 입력을 종료하여 키보드를 내림
    }
    
    @objc private func moveToMainVC() {
        UserDefaults.standard.setValue("test", forKey: "realtimedatabase")
        self.moveToMain()
    }


    
// MARK: End
    
}

// MARK: End







extension AuthVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          // 현재 텍스트와 새 텍스트를 결합하여 총 길이를 계산
          let currentText = textField.text ?? ""
          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
          
          // 최대 글자 수 11자로 제한
          if updatedText.count > 11 {
              return false
          }
          
          // 글자 수가 11에 도달하면 키보드를 내리고 함수 호출
          if updatedText.count == 11 {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // 지연을 주어 키보드가 완전히 내려간 후 함수 호출
                  self.dismissKeyboard()
                  self.inputComplete()
              }
          }

          return true
      }
}
