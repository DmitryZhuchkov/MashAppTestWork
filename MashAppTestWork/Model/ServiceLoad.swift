//
//  ServiceLoad.swift
//  MashAppTestWork
//
//  Created by Дмитрий Жучков on 09.03.2021.
//

import Foundation
import Moya
class ServiceLoad {
    static let load = ServiceLoad()
    let service = MoyaProvider<HotelService.DataProvider>()
    let jsonDecoder = JSONDecoder()
    func loadInfo(completed: @escaping (JSONDecode?)->()) {
        service.request(.readInfo) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
            let jsonData = try? strongSelf.jsonDecoder.decode(JSONDecode.self, from: response.data)
            completed(jsonData)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
