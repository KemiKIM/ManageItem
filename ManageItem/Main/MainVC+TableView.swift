//
//  ViewController+TableView.swift
//  ManageItem
//
//  Created by 김성호 on 9/4/24.
//

import UIKit


// MARK: [ TableView Delegate ]
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    // 최소 높이 반환
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(60, UITableView.automaticDimension) // 최소 높이를 60으로 설정
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.receiveArray.count
        return self.isSearching ? self.filteredItems.count : self.allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTVC.identifier, for: indexPath) as? ItemTVC else {
            return UITableViewCell()
        }
        
        let currentItem = self.isSearching ? self.filteredItems[indexPath.row] : self.allItems[indexPath.row]
        
        cell.divisionLabel1.text = currentItem.name
        cell.divisionLabel2.text = currentItem.partName
        cell.divisionLabel3.text = currentItem.partNumber
        cell.divisionLabel4.text = currentItem.location

        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 테이블 뷰의 셀을 선택했을 때 UI에 나타나는 효과
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentItem = self.isSearching ? self.filteredItems[indexPath.row] : self.allItems[indexPath.row]
        
        let detail = "장비명: \(currentItem.name)\n\n부품명: \(currentItem.partName)\n\n파트번호: \(currentItem.partNumber)\n\n위치: \(currentItem.location)"
        
        self.selectAlert(title: detail, message: "") {
            UserDefaults.standard.setValue("edit", forKey: "move")
            
            let add = AddVC()
            if self.isSearching {
                
                
                for (index, i) in self.allItems.enumerated() {
                    if
                        i.name == currentItem.name &&
                            i.partName == currentItem.partName &&
                            i.partNumber == currentItem.partNumber &&
                            i.location == currentItem.location
                    {
                        add.receiveText(index: index, currentItem: currentItem)
                        self.moveToOtherVC(vc: add)
                        break
                    }
                }
                
                
                
                
                
            } else {
                add.receiveText(index: indexPath.row, currentItem: currentItem)
                self.moveToOtherVC(vc: add)
            }
            
        }
        
    }
  
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            return // 이미 새로고침이 진행 중이면 회전하지 않음
        }

        let pullDistance = max(0.0, -scrollView.contentOffset.y) // 스크롤의 당긴 거리
        let rotationAngle = pullDistance / 100.0 * CGFloat.pi // 회전 각도 계산
        self.refreshImg.transform = CGAffineTransform(rotationAngle: rotationAngle) // 이미지 회전
    }
    
}

