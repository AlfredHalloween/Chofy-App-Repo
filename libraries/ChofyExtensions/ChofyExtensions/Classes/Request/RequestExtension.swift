//
//  RequestExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Combine

open class RequestBaseManager {
    
    public init() { }
    
    open func single<T: Decodable>(url: String,
                                   type: T.Type,
                                   method: HTTPMethod,
                                   parameters: Parameters? = nil,
                                   headers: HTTPHeaders? = nil,
                                   decodingKey: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Single<T> {
        let encoder: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        return Single.create { single in
            let disposables: Disposable = Disposables.create()
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: encoder,
                       headers: headers)
                .validate(statusCode: 200...201)
                .responseData { responseData in
                    let statusCode = responseData.response?.statusCode
                    guard let response = responseData.data else {
                        single(.failure(RequestError.noResponse))
                        return
                    }
                    switch statusCode {
                    case 200, 201:
                        do {
                            let jsonDecoder = JSONDecoder()
                            jsonDecoder.keyDecodingStrategy = decodingKey
                            let data = try jsonDecoder.decode(type, from: response)
                            single(.success(data))
                            return
                        } catch {
                            single(.failure(RequestError.errorParsing))
                            return
                        }
                    default:
                        do {
                            let data = try JSONDecoder().decode(ErrorResponse.self, from: response)
                            single(.failure(data))
                            return
                        } catch {
                            single(.failure(RequestError.errorParsing))
                            return
                        }
                    }
                }
            return disposables
        }
    }
}
