//
//  ViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController

class MainViewController: BaseViewController, ViewModelBindableType {
    
    let mainView = MainView()
    var viewModel: MainViewModel!
    var service : WeatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func initialize() {
        view = mainView
        setRegister()
    }
    
    func setRegister() {
        mainView.todayWeatherInfoView.todayCollectionView.register(TodayCollectionViewCell.self
                                                                   ,forCellWithReuseIdentifier: TodayCollectionViewCell.registerId)
        
        mainView.weeklyWeatherInfoView.tableView
            .register(WeelyTableViewCell.self, forCellReuseIdentifier: WeelyTableViewCell.registerId)
    }
    
    func bindInput() {

        mainView
            .searchView
            .searchBar
            .rx
            .textDidBeginEditing
            .bind { [weak self] _ in
                guard let self = self else {return}
                var vc = SearchViewController()
                vc.bind(viewModel: SearchViewModel())
                self.pushVC(vc)
            }.disposed(by: self.disposeBag)
    }
    
    func bindOutput() {
        
        //MARK: -  현재날씨
        viewModel
            .output
            .currentWeather
            .bind(to: mainView.currentWeatherView.rx.text)
            .disposed(by: self.disposeBag)
        
        //MARK: -  실시간 날씨
        viewModel
            .output
            .todayWeather
            .bind(to: mainView.todayWeatherInfoView.rx.text)
            .disposed(by: self.disposeBag)
        
        //MARK: -  실시간 날씨 아이콘 등등
        viewModel
            .output
            .hourWeather
            .bind(to: mainView
                .todayWeatherInfoView
                .todayCollectionView
                .rx
                .items(cellIdentifier: TodayCollectionViewCell.registerId,
                       cellType: TodayCollectionViewCell.self)) { [weak self] row, tableData, cell in
                print("row 1:\(row)")
                cell.setUpdate(tableData, row)
                
            }.disposed(by: self.disposeBag)
        
        //MARK: - 5일간 날씨
        self.mainView
            .weeklyWeatherInfoView
            .tableView
            .rx
            .observe(CGSize.self, "contentSize")
            .bind { [weak self] size in
                guard let self = self else {return}
                guard let height = size?.height else { return }
                
                self.mainView
                    .weeklyWeatherInfoView
                    .tableView
                    .snp.updateConstraints { make in
                        make.height.equalTo(height)
                    }
                
            }.disposed(by: self.disposeBag)
        
        viewModel
            .output
            .weeklyWeather
            .bind(to: mainView
                .weeklyWeatherInfoView
                .tableView
                .rx
                .items(cellIdentifier: WeelyTableViewCell.registerId, cellType: WeelyTableViewCell.self)) { [weak self] row , tableData, cell in
                    cell.selectionStyle = .none
                    
                    cell.dayWeatherUpdate(tableData)
                }.disposed(by: self.disposeBag)
        
        //MARK: - MapView
        viewModel
            .output
            .coordinate
            .bind(to: mainView.mapView.rx.coordinates)
            .disposed(by: self.disposeBag)
        
        //MARK: - 상세날씨
        viewModel
            .output
            .detailWeather
            .bind(to: mainView.weatherConditionsView.rx.text)
            .disposed(by: self.disposeBag)
        
        
        //MARK: - update
        SearchNotificationCenter
            .coordinate
            .addObserver()
            .bind { [weak self] data in
                guard let self = self else {return}
                
                let coord = data as? Coordinates
                let lat = coord?.lat ?? 0.0
                let lon = coord?.lon ?? 0.0
                self.viewModel
                    .getWeater(lat: lat, lon: lon)
            }.disposed(by: self.disposeBag)
        
        viewModel
            .input
            .didRefresh
            .accept(())
        
    }
}

