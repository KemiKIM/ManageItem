//
//  ViewController+SearchBar.swift
//  ManageItem
//
//  Created by 김성호 on 9/4/24.
//

import UIKit

// MARK: [ Serachbar Delegate ]
extension MainVC: UISearchBarDelegate {
    
    // 검색 바 텍스트가 변경될 때마다 호출되는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.filteredItems = self.allItems
            self.isSearching = false
        } else {
            self.isSearching = true
            self.filteredItems = self.allItems.filter { item in
                return item.name.localizedCaseInsensitiveContains(searchText) ||
                item.partName.localizedCaseInsensitiveContains(searchText) ||
                item.partNumber.localizedCaseInsensitiveContains(searchText) ||
                item.location.localizedCaseInsensitiveContains(searchText)
            }
        }

        BamYangGang.debug("검색 및 갱신")
        self.mainTableView.reloadData()
        
    }
    
    
    // 검색 바에서 검색이 시작될 때 호출되는 메서드
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        for cell in self.mainTableView.visibleCells {
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0.5
            }
        }
        
    }
    
    // 검색 바에서 검색이 종료될 때 호출되는 메서드
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        for cell in self.mainTableView.visibleCells {
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 1.0
            }
        }
    }
}
