//
//  SearchView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class SearchView : DefaultView {
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .LightBlue
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .LightBlue
    }
   
    let tableView = UITableView().then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.contentInsetAdjustmentBehavior = .never
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.separatorColor = .clear
        $0.isHidden = false
    }
    
    let isEmptyView = UIView().then {
        $0.backgroundColor = .clear
        $0.isHidden = true
    }
    
    let isEmptyLabel = UILabel().then {
        $0.text = "검색 결과가 없습니다.\n다시 검색해주세요"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 40)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
   
        addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview(tableView)
        contentView.addSubviews([tableView,
                                isEmptyView])
        isEmptyView.addSubview(isEmptyLabel)
        searchView.backButton.isHidden = false
    }
    
    func setLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.searchView.snp.bottom)
           make.left.right.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        isEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        isEmptyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
}
