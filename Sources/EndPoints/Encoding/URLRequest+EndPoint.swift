//
//  URLRequest+Configurations.swift
//
//  Created by Raymund Catahay on 2018-10-26.
//

import Foundation

@available(OSX 10.13, *)
extension URLRequest {
    
    mutating public func encodeBodyParameters(_ parameters: Body) {
        BodyParameterEncoder.encode(urlRequest: &self, with: parameters)
    }

    mutating public func encodeHeaders(_ headers: [String : String]) {
        StandardHeaderEncoder.encode(urlRequest: &self, with: headers)
    }
    
    mutating public func encodeURLParameters(_ parameters: URLParameter) {
        URLParameterEncoder.encode(&self, with: parameters)
    }
}
