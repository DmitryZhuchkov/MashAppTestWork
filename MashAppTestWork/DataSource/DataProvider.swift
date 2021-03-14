//
//  DataProvider.swift
//  MashAppTestWork
//
//  Created by Дмитрий Жучков on 08.03.2021.
//
import Foundation
import Moya

enum HotelService {
    enum DataProvider: TargetType {
        case readInfo
        var baseURL: URL {
            return URL(string: "https://stage.staystories.me/api/v10/bcom/dest")!
        }
        var path: String {
            switch self {
            case .readInfo:
                return ""
                
            }
        }
        var method: Moya.Method {
            return .post
        }

        var sampleData: Data {
            return Data()
        }

        var task: Task {
            switch self {
            case .readInfo:
                return .requestParameters(parameters: ["city":"20014181"], encoding: JSONEncoding.default)
            }
        }
        var headers: [String : String]? {
            return ["Accept": "application/json"]
        }
    }
}
