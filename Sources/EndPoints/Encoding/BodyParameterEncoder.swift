//
//  JSONParameterEncoder.swift
//
//  Created by Raymund Catahay on 2018-10-26.
//

import Foundation

@available(OSX 10.13, *)
public class BodyParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Body) {
        switch parameters {
        case .encodable(let encodableParameter):
            if let dataParameters = encodableParameter.toJSONData() {
                urlRequest.httpBody = dataParameters
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

public extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
