//
//  FiveWeatherInfoView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit

class WeeklyWeatherInfoView : BaseView {
    
    let titleLabel = UILabel().then {
        $0.text = "5일간 일기예보"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubviews([titleLabel,
                    tableView])
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(12)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
}
