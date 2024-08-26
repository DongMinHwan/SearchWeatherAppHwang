//
//  DayWeatherInfoView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class TodayWeatherInfoView : BaseView {
    
    let gustLabel = UILabel().then {
        $0.text = "5일간의 일기예보"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .white
    }
    
    let seperatorView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    let todayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {

        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 55.0, height: 80.0)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0 , left: 0, bottom: 0, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
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
        addSubviews([gustLabel,
                    seperatorView,
                     todayCollectionView])
    }
    
    func setLayout() {

        gustLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(gustLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(1)
        }
        
        todayCollectionView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(12)
//            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
    }
    
    func todayWeatherUpdate(_ data : TodayWeather) {
        gustLabel.text = "돌풍의 풍속은 최대 \(Int(data.gust)) m/s입니다."
    }
}

extension Reactive where Base: TodayWeatherInfoView {
    var text : Binder<TodayWeather> {
        return Binder(self.base) { view ,currentweather in
            view.todayWeatherUpdate(currentweather)
        }
    }
}
