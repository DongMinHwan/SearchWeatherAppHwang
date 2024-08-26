//
//  SearchHeaderView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit

import UIKit
import SnapKit

class SearchHeaderView: UIView {
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    let backButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    var searchBar = UISearchBar().then {
        $0.placeholder = "Search"
        $0.barTintColor = .LightBlue
        $0.searchBarStyle = .minimal
        $0.isTranslucent = false
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
        addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(backButton)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(45)
        }
    }
}
