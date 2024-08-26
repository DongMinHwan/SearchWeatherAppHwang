//
//  SearchViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: BaseViewController, ViewModelBindableType, UISearchBarDelegate {
    
    var mainView = SearchView()
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        setRegister()
    }
    
    
    func setRegister() {
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.registerId)
    }
    
    func bindInput() {
        
        self.mainView
            .tableView
            .rx
            .modelSelected(SearchResponse.self)
            .bind { [weak self] data in
                guard let self = self else { return }
                
                SearchNotificationCenter
                    .coordinate
                    .post(object: data.coord)
                
                self.popViewController()
                
            }.disposed(by: self.disposeBag)
        
        self.mainView
            .searchView
            .backButton
            .rx
            .tap
            .bind { [weak self] _ in
                
                guard let self = self else { return }
                
                self.popViewController()
                
            }.disposed(by: self.disposeBag)
    }
    
    func bindOutput() {
        
        //MARK: - 테이블뷰 셀높이
        self.mainView
            .tableView
            .rx
            .observe(CGSize.self, "contentSize")
            .bind { [weak self] size in
                guard let self = self else {return}
                guard let height = size?.height else { return }
                self.mainView
                    .tableView
                    .snp.updateConstraints { make in
                        make.height.equalTo(height)
                    }
            }.disposed(by: self.disposeBag)
        
        
        viewModel
            .output
            .searchList
            .bind(to:
                    mainView.tableView
                .rx
                .items(cellIdentifier: SearchTableViewCell.registerId,
                       cellType: SearchTableViewCell.self)) { [weak self] row, tableData, cell in
                guard let self = self else {return}
                
                cell.selectionStyle = .none
                cell.setUpdate(tableData)
            }
                       .disposed(by: self.disposeBag)
        
        //빈화면처리
        viewModel
            .input
            .isEmpty
            .bind { [weak self] isEmpty in
                guard let self = self else {return}
                if let data = mainView.searchView.searchBar.text?.isEmpty {
                    print("data : \(data)")
                    if data == false {
                        print("isEmmpty : \(isEmpty)")
                        self.mainView.tableView.isHidden = !isEmpty
                        self.mainView.isEmptyView.isHidden = isEmpty
                    }
                }
//                if ((mainView.searchView.searchBar.text?.isEmpty) == nil) {
//
//                }
            }.disposed(by: self.disposeBag)
        
        self.paging() //페이징 처리
        self.search() //검색
        
        viewModel
            .input
            .didRefresh
            .accept(())
    }
    
    func paging() {
        
        self.mainView
            .scrollView
            .rx
            .didScroll
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                let contentOffsetY = self.mainView.scrollView.contentOffset.y
                let contentHeight = self.mainView.scrollView.contentSize.height
                let boundsHeight = self.mainView.scrollView.bounds.size.height
                if contentOffsetY > contentHeight - boundsHeight {
                    self.viewModel.input.loadMore.accept(())
                }
            }.disposed(by: self.disposeBag)
    }
    
    func search() {
        
        self.mainView
            .searchView
            .searchBar
            .rx
            .text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)  // Adjust debounce time
            .distinctUntilChanged()
            .map { [unowned self] text in
                return self.viewModel.allCities.filter { $0.name.lowercased().contains(text.lowercased()) }
            }
            .bind(to: viewModel.output.filterSearchList)
            .disposed(by: disposeBag)
        
        self.mainView
            .searchView
            .searchBar
            .rx
            .searchButtonClicked
            .bind { [weak self] _ in
                self?.mainView.searchView.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
    }
    
    func configureSearchBar() {
        
    }
}


