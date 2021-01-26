//
//  URLParameterEncoder.swift
//  RebtelCoreNetwork
//
//  Created by Raymund Catahay on 2018-10-28.
//  Copyright © 2018 Rebtel. All rights reserved.
//

import Foundation

public class URLParameterEncoder {
    
    public static func encode(
        _ urlRequest: inout URLRequest,
        with parameters: URLParameter) {
        guard let url = urlRequest.url else { return }
        switch parameters {
        case .dictionary(let parameters):
            if var urlComponents = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false),
               !parameters.isEmpty {
                urlComponents.queryItems = [URLQueryItem]()
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(
                        name: key,
                        value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlComponents.url
            }
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        }
    }
}
