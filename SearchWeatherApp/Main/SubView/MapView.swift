//
//  MapView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import MapKit
import SnapKit
import Then
import RxSwift

class MapView : BaseView, MKMapViewDelegate {
    
    let mapViewTitleLabel = UILabel().then {
        $0.text = "강수량"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        mapView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubviews([mapViewTitleLabel,
                     mapView])
    }
    
    func setLayout() {
        
        mapViewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(12)
        }
        
//        mapView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.height.equalTo(400)
//        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(mapViewTitleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func mapViewUpdate(_ coordinate : Coordinates) {
        let center = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        mapView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)), animated: true)
        self.mapMarker(coordinate)
    }
    
    func mapMarker(_ coordinate : Coordinates) {
        let marker = MKPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
        mapView.addAnnotation(marker)
    }
}

extension Reactive where Base : MapView {
    var coordinates : Binder<Coordinates> {
        return Binder(self.base) { view, coord in
            view.mapViewUpdate(coord)
        }
    }
}
