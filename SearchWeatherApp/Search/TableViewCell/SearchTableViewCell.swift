//
//  SearchTableViewCell.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class SearchTableViewCell : UITableViewCell {
    
    static let registerId = "\(SearchTableViewCell.self)"
    
    let stackView = VerticalStackView().then {
        $0.spacing = 8
    }
    
    let cityNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
    }
    
    let countryLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 10)
    }
    
    let seperatorView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
        backgroundColor = .DeepSkyBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI(){
        addSubview(stackView)
        stackView.autoArrangedSubView([cityNameLabel,
                                      countryLabel,
                                      seperatorView])
        
        stackView.setCustomSpacing(12, after: countryLabel)
    }
    
    func setLayout() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(14)
            make.bottom.equalToSuperview()
        }
    }
    
    func setUpdate(_ data : SearchResponse) {
        
        cityNameLabel.text = data.name
        countryLabel.text = data.country
        
    }
}

extension Reactive where Base: SearchTableViewCell {
    var text: Binder<SearchResponse> {
        return Binder(self.base) { view, cities in
            view.setUpdate(cities)
        }
    }
}
