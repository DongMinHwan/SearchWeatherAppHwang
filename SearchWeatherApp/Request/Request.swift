//
//  Request.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation
import Alamofire

class Request {
    
    static var baseUrl: String {
    
        get {
            return Constant.API.url
        }
    }
    
    static private func handleError(_ response: DataResponse<Any, AFError>) -> ErrorModel? {
        if let result = response.data {

            if let error = try? JSONDecoder().decode(ErrorModel.self, from: result) {
                return error
            }
      
        }
        
       // Toast(text: "ToastDisconnect".localized()).show()
        return nil
    }
    
    static func get(param: Parameters, completion: @escaping (_ data: Data?) -> Void, exception: @escaping (_ error: ErrorModel) -> Void = { error in }) {
        var url: String
        url = baseUrl
        let alamo = AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<300)
        alamo.responseJSON { [self] response in
            switch response.result {
                case .success:
                completion(response.data)
                    return
                default:
                    if let error = handleError(response) {
                        
                        exception(error)
                    }
                return
            }
        }
    }
}
