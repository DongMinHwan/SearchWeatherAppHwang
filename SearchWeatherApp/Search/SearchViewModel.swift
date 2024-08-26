//
//  SearchViewModel.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import RxSwift
import RxCocoa

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel, ViewModelType {

    struct Input {
        var didRefresh = PublishRelay<Void>()
        var loadMore = PublishRelay<Void>()
        var searchString = PublishSubject<String>()
        var isEmpty = PublishRelay<Bool>()
    }

    struct Output {
        var searchList = BehaviorRelay<[SearchResponse]>(value: [])
        var filterSearchList = PublishSubject<[SearchResponse]>()
        var isLoading = BehaviorRelay<Bool>(value: false)
    }

    var input: Input
    var output: Output

    var allCities = [SearchResponse]()
    
    private var currentPage = 0
    private let pageSize = 100

    init(input: Input = Input(),
         output: Output = Output()) {

        self.input = input
        self.output = output
        super.init()

        input.didRefresh
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.currentPage = 0
                self.loadAndParseJson(isInitialLoad: true)
            }
            .disposed(by: self.disposeBag)

        input.loadMore
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.loadAndParseJson(isInitialLoad: false)
            }
            .disposed(by: self.disposeBag)
   
        output.filterSearchList
            .bind { [weak self] data in
                guard let self = self else {return}
                
                if !data.isEmpty {
                    self.output.searchList.accept(data)
                    self.input.isEmpty.accept(true)
                }else {
                    self.input.isEmpty.accept(false)
                }
                
            }.disposed(by: self.disposeBag)
    }

    private func loadAndParseJson(isInitialLoad: Bool) {
        self.output.isLoading.accept(true)
        let fileName: String = "reduced_citylist"
        let extensionType: String = "json"

        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            print("Error: File not found.")
            self.output.isLoading.accept(false)
            return
        }

        do {
            let data = try Data(contentsOf: fileLocation)
            let newCities = try JSONDecoder().decode([SearchResponse].self, from: data)
            
            if isInitialLoad {
                self.allCities = newCities
            }
            
            let start = currentPage * pageSize
            let end = min(start + pageSize, allCities.count)
            let limitedCities = Array(allCities[start..<end])
            
            if isInitialLoad {
                output.searchList.accept(limitedCities)
            } else {
                let updatedList = output.searchList.value + limitedCities
                output.searchList.accept(updatedList)
            }
            currentPage += 1
            self.output.isLoading.accept(false)
            
        } catch {
            
            self.output.isLoading.accept(false)
        }
    }

}
